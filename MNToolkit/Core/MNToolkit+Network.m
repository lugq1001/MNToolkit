//
//  MNToolkit+Network.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/21.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNToolkit.h"

static const NSUInteger kNetworkTimeOut = 30.0f;
static NSString * const kMethodPost = @"POST";
static NSString * const kMethodGet = @"GET";

@implementation MNToolkit (Network)

+ (void)http:(NSString *)method url:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSData *result, NSError *error))callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kNetworkTimeOut];
    
    [request setHTTPMethod:method];
    if(params != nil) {
        NSMutableString *paramStr = [NSMutableString new];
        for(NSString *key in params) {
            [paramStr appendFormat:@"%@=%@&",key,params[key]];
        }
        [request setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //              回主线程更新UI
        //        });
        if ([data length] > 0 && error == nil) {
            //请求成功
        } else if([data length] == 0 && error == nil) {
            //没有数据
            error = [NSError errorWithDomain:@"MNToolkit" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"数据为空"}];
        } else if(error != nil) {
            //超时
            error = [NSError errorWithDomain:@"MNToolkit" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"请求超时"}];
        }
        callback(data, error);
    }];
    [task resume];
}

+ (NSData *)httpDownloadFile:(NSString *)method url:(NSString *)url withParams:(NSDictionary *)params storePath:(NSString *)storePath fileName:(NSString *)fileName callback:(void(^)(NSData *data, NSError *error))callback
{
    NSString *filePath = [storePath stringByAppendingPathComponent:fileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSData dataWithContentsOfFile:filePath];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    
    if(params != nil) {
        NSMutableString *paramStr = [NSMutableString new];
        for(NSString *key in params) {
            [paramStr appendFormat:@"%@=%@&",key,params[key]];
        }
        if ([method isEqualToString:kMethodGet]) {
            url = [url stringByAppendingFormat:@"?%@",paramStr];
        } else if ([method isEqualToString:kMethodPost])
            [request setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [request setURL:[NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setHTTPMethod:method];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLSessionTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        if ([data length] > 0 && error == nil) {
            //请求成功
        } else if([data length] == 0 && error == nil) {
            //没有数据
            error = [NSError errorWithDomain:@"MNToolkit" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"数据为空"}];
        } else if(error != nil) {
            //超时
            error = [NSError errorWithDomain:@"MNToolkit" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"请求超时"}];
        }
        callback(data, error);
    }];

    [task resume];
    return nil;
}

+ (void)httpPost:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSData *result, NSError *error))callback
{
    [self http:kMethodPost url:url params:params callback:callback];
}

+ (void)httpGet:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSData *result, NSError *error))callback
{
    [self http:kMethodGet url:url params:params callback:callback];
}

+ (void)httpUploadFile:(NSString *)url withParams:(NSDictionary *)params andFile:(NSArray *)files callback:(void (^)(NSData *result, NSError *error))callback
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSMutableData *uploadData = [NSMutableData new];
    
    NSString *hyphens = @"--";
    NSString *boundary = @"*****";
    NSString *line = @"\r\n";
    
    if(params != nil) {
        NSMutableString *paramStr = [NSMutableString new];
        
        for(NSString *key in params) {
            [paramStr appendString:hyphens];
            [paramStr appendString:boundary];
            [paramStr appendString:line];
            
            //添加字段名称
            [paramStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
            [paramStr appendString:line];
            [paramStr appendString:line];
            
            //添加字段的值
            [paramStr appendFormat:@"%@",params[key]];
            [paramStr appendString:line];
            /*
             --*****
             content-disposition: form-data; name="field1"
             
             value
             */
        }
        [uploadData appendData:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    int i = 0;
    for(NSString *path in files) {
        NSData *data = [NSData dataWithContentsOfFile:path];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        if(UIImagePNGRepresentation(image)) {
//            data = UIImagePNGRepresentation(image);
//        } else {
//            data = UIImageJPEGRepresentation(image, 1.0);
//        }
        
        [uploadData appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [uploadData appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [uploadData appendData:[line dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        //要上传的文件名和key，服务器端用file接收
        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"",[NSString stringWithFormat:@"file%d",i + 1],[NSString stringWithFormat:@"image%d.png",i + 1]];
        [fileTitle appendString:line];
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:image/png"]];
        [fileTitle appendString:line];
        [fileTitle appendString:line];
        
        [uploadData appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [uploadData appendData:data];
        [uploadData appendData:[line dataUsingEncoding:NSUTF8StringEncoding]];
        i++;
        /*
         --*****
         content-disposition: form-data; name="file"; filename="image.png"
         Content-Type: image/png
         
         ... contents of boris.png ...
         */
        
    }
    //--*****--
    [uploadData appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [uploadData appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [uploadData appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [uploadData appendData:[line dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kNetworkTimeOut];
    [request setHTTPMethod:kMethodPost];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[uploadData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:uploadData];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:uploadData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
        callback(data, error);
    }];
    [task resume];
}

+ (NSData *)httpDownloadFilePost:(NSString *)url withParams:(NSDictionary *)params storePath:(NSString *)storePath fileName:(NSString *)fileName callback:(void(^)(NSData *data, NSError *error))callback
{
    return [self httpDownloadFile:kMethodPost url:url withParams:params storePath:storePath fileName:fileName callback:callback];
}

+ (NSData *)httpDownloadFileGet:(NSString *)url withParams:(NSDictionary *)params storePath:(NSString *)storePath fileName:(NSString *)fileName callback:(void(^)(NSData *data, NSError *error))callback
{
    return [self httpDownloadFile:kMethodGet url:url withParams:params storePath:storePath fileName:fileName callback:callback];
}




@end

//
//  MNToolkit+Network.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/21.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNToolkit.h"
#import "MNCryptor.h"

static const NSUInteger kNetworkTimeOut = 30.0f;
static NSString * const kMethodPost = @"POST";
static NSString * const kMethodGet = @"GET";

@implementation MNToolkit (Network)

+ (void)httpRequest:(NSString *)url
             params:(NSDictionary *)params
           callback:(void(^)(NSData *result, NSError *error))callback
{
    [self request:url params:params callback:callback];
}

+ (void)httpRequest:(NSString *)url
   uploadWithParams:(NSDictionary *)params
          filePaths:(NSArray *)filePaths
           callback:(void (^)(NSData *result, NSError *error))callback
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
    for(NSString *path in filePaths) {
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


+ (void)httpRequest:(NSString *)url
 downloadWithParams:(NSDictionary *)params
          storePath:(NSString *)storePath
           fileName:(NSString *)fileName
           callback:(void(^)(NSString *filePath, NSError *error))callback
{
    NSString *filePath = [storePath stringByAppendingPathComponent:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:nil];
    }
    
    NSMutableURLRequest *request = [self mutableURLRequest:url params:params];

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLSessionTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            callback(nil, error);
            return;
        }
        NSData *data = [NSData dataWithContentsOfURL:location];
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [handle writeData:data];
        callback(filePath, nil);
    }];
    [task resume];
}

+ (void)httpRequest:(NSString *)url
    imageWithParams:(NSDictionary *)params
           callback:(void(^)(NSString *imagePath, NSError *error))callback
{
    NSString *filePath = [[MNToolkit sandboxPathImages] stringByAppendingPathComponent:[MNCryptor md5:url]];
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath]) {
        callback(filePath, nil);
        return;
    }
    
    NSMutableURLRequest *request = [self mutableURLRequest:url params:params];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLSessionTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            callback(nil, error);
            return;
        }
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        if([[url pathExtension] isEqualToString:@"png"]) {
            [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        } else {
            [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath atomically:YES];
        }
        callback(filePath, nil);
    }];
    [task resume];
}

+ (void)request:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSData *result, NSError *error))callback
{
    NSMutableURLRequest *request = [self mutableURLRequest:url params:params];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //              回主线程更新UI
        //        });
//        if ([data length] > 0 && error == nil) {
//            //请求成功
//        } else if([data length] == 0 && error == nil) {
//            //没有数据
//            error = [NSError errorWithDomain:@"MNToolkit" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"数据为空"}];
//        } else if(error != nil) {
//            //超时
//            error = [NSError errorWithDomain:@"MNToolkit" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"请求超时"}];
//        }
        callback(data, error);
    }];
    [task resume];
}

+ (NSString *)makeupUrlForHttpGet:(NSString *)url param:(NSDictionary *)params
{
    NSMutableString *paramStr = [NSMutableString new];
    for(NSString *key in params) {
        [paramStr appendFormat:@"%@=%@&",key,params[key]];
    }
    return [url stringByAppendingFormat:@"?%@",paramStr];
}

+ (NSMutableURLRequest *)mutableURLRequest:(NSString *)url params:(NSDictionary *)params
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kNetworkTimeOut];
    if(params != nil) {//post
        NSMutableString *paramStr = [NSMutableString new];
        for(NSString *key in params) {
            [paramStr appendFormat:@"%@=%@&",key,params[key]];
        }
        [request setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:kMethodPost];
    } else {//get
        [request setHTTPMethod:kMethodGet];
    }
    return request;
}


@end

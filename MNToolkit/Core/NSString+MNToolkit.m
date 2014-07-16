//
//  NSString+MNToolkit.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "NSString+MNToolkit.h"

@implementation NSString (MNToolkit)

- (NSString *)reverse
{
    NSMutableString *result = [NSMutableString string];
    NSUInteger len = [self length];
    for (NSUInteger i = len; i > 0; i--) {
        [result appendString:[self substringWithRange:NSMakeRange(i - 1, 1)]];
    }
    return result;
}

- (BOOL) isBlankOrNil
{
    return !self || self == nil || self.length == 0;
}

- (void)showAlertTitle:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showAlertMessage:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:self delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (NSString*)newDateFrom:(NSString *)from to:(NSString*)format;
{
    NSString* dateStr = self;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:from];
    NSDate *date = [dateFormat dateFromString:self];
    
    [dateFormat setDateFormat:format];
    dateStr = [dateFormat stringFromDate:date];
    return dateStr == nil ? @"" : dateStr;
}

@end

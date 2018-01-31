//
//  FJRegularExpressionManager.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/27.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJRegularExpressionManager.h"

@implementation FJRegularExpressionManager

/**
 匹配手机号
 */
+ (NSMutableArray *)matchMobileLink:(NSString *)text{
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc]initWithPattern:@"(\\(86\\))?(13[0-9]|15[0-35-9]|18[0125-9])\\d{8}" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    NSArray *resultArray = [regularExpression matchesInString:text options:0 range:text.rangeOfAll];
    
    [resultArray enumerateObjectsUsingBlock:^(NSTextCheckingResult  *result, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * string = [text substringWithRange:result.range];
       
        [mutableArray addObject:string];
    }];
    
    return mutableArray;
}
/**
 匹配网址
 */
+ (NSMutableArray *)matchWebLink:(NSString *)text{
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc]initWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    NSArray *resultArray = [regularExpression matchesInString:text options:0 range:text.rangeOfAll];
    
    [resultArray enumerateObjectsUsingBlock:^(NSTextCheckingResult  *result, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * string = [text substringWithRange:result.range];
         
        [mutableArray addObject:string];
    }];
    
    return mutableArray;
}



@end

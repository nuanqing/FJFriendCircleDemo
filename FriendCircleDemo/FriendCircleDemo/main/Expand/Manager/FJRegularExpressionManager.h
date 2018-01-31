//
//  FJRegularExpressionManager.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/27.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJRegularExpressionManager : NSObject

/**
 匹配手机号
 */
+ (NSMutableArray *)matchMobileLink:(NSString *)text;
/**
 匹配网址
 */
+ (NSMutableArray *)matchWebLink:(NSString *)text;

@end

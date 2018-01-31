//
//  NSString+FJDate.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/31.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FJDate)
+ (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)stringWithDateString:(NSString *)dateString;
@end

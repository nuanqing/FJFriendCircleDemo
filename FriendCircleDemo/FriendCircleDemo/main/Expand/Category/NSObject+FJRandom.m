//
//  NSObject+FJRandom.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/24.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "NSObject+FJRandom.h"

@implementation NSObject (FJRandom)
+ (NSInteger)fj_randomNumber:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}
@end

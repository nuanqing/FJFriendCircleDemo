//
//  FJLine.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/28.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJLine.h"

@implementation FJLine

+ (instancetype)line{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    self.backgroundColor = FJGlobalBottomLineColor;
}

@end

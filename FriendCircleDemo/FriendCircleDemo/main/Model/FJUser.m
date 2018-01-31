//
//  FJUser.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJUser.h"

@implementation FJUser


- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
    self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
    return self;
}

@end

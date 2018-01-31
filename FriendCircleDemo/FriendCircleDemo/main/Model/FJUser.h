//
//  FJUser.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJUser : NSObject<NSCoding>

/** userId */
@property (nonatomic , copy) NSString *userId;

/** 用户昵称 */
@property (nonatomic , copy) NSString *nickname;

/** 头像地址 */
@property (nonatomic , copy) NSString *avatarUrl;

@end

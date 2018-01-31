//
//  FJUserManager.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/29.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FJUser;
@interface FJUserManager : NSObject

+(FJUserManager *)sharedManager;

@property (nonatomic,strong) FJUser *user;

/** userId */
@property (nonatomic,copy,readonly) NSString *userId;

/** 用户昵称 */
@property (nonatomic,copy,readonly) NSString *nickname;

/** 头像地址 */
@property (nonatomic,copy,readonly) NSString *avatarUrl;
/**数据 */
@property (nonatomic,copy) NSDictionary *userInfoDict;

- (void)removeObject;

@end

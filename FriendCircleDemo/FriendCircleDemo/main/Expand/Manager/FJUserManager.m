//
//  FJUserManager.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/29.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJUserManager.h"
#import "FJUser.h"

@interface FJUserManager()


/** userId */
@property (nonatomic,copy) NSString *userId;

/** 用户昵称 */
@property (nonatomic,copy) NSString *nickname;

/** 头像地址 */
@property (nonatomic,copy) NSString *avatarUrl;
/**数据 */
@property (nonatomic,strong) YYCache *userCahce;



@end

@implementation FJUserManager

+(FJUserManager *)sharedManager{
    static FJUserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[FJUserManager alloc]init];
    });
    return userManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCache];
    }
    return self;
}


- (void)setupCache{
    
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:FJUserTablePath];
    self.userCahce = [[YYCache alloc]initWithPath:path];
    
}

- (void)setUserInfoDict:(NSDictionary *)userInfoDict{
    _userInfoDict = userInfoDict;
    _user = [FJUser modelWithDictionary:self.userInfoDict];
    [self.userCahce setObject:_user forKey:FJUserKey];
   
}

- (FJUser *)user{
    return (FJUser *)[self.userCahce objectForKey:FJUserKey];
}


- (NSString *)userId{
    return [(FJUser *)[self.userCahce objectForKey:FJUserKey] userId];
}

- (NSString *)nickname{
    return [(FJUser *)[self.userCahce objectForKey:FJUserKey] nickname];
}

- (NSString *)avatarUrl{
    return [(FJUser *)[self.userCahce objectForKey:FJUserKey] avatarUrl];
}

- (void)removeObject{
    [self.userCahce removeObjectForKey:FJUserKey];
}

@end

//
//  FJCommentReplyManager.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/30.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJCommentReplyManager.h"

@interface FJCommentReplyManager()

@property (nonatomic,strong) YYCache *cache;

@property (nonatomic,copy) NSString *recordText;

@end

@implementation FJCommentReplyManager

+ (instancetype)manager{
    return [[self alloc]init];
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
    _cache = [YYCache cacheWithName:FJCommentTablePath];
    [_cache removeAllObjects];
}

- (void)setCommentText:(NSString *)text commentId:(NSString *)commentId{
  
    if (FJStringIsNotEmpty(text) && FJStringIsNotEmpty(commentId)) {
        [self.cache setObject:text forKey:commentId];
    }
}

- (void)setCommentReplyText:(NSString *)text topicId:(NSString *)topicId{
    if (FJStringIsNotEmpty(text) && FJStringIsNotEmpty(topicId)) {
        [self.cache setObject:text forKey:topicId];
    }
}


- (NSString *)textWithCommentId:(NSString *)commentId{
    return (NSString *)[self.cache objectForKey:commentId];
}

- (NSString *)textWithTopicId:(NSString *)topicId{
     return (NSString *)[self.cache objectForKey:topicId];
}

- (void)removeid:(NSString *)lastId{
    [self.cache removeObjectForKey:lastId];
}





@end

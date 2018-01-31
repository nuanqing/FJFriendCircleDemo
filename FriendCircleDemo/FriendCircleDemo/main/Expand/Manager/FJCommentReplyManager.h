//
//  FJCommentReplyManager.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/30.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FJCommentReplyManager : NSObject

+ (instancetype)manager;

- (void)setCommentText:(NSString *)text commentId:(NSString *)commentId;

- (NSString *)textWithCommentId:(NSString *)commentId;

- (void)setCommentReplyText:(NSString *)text topicId:(NSString *)topicId;

- (NSString *)textWithTopicId:(NSString *)topicId;

- (void)removeid:(NSString *)lastId;

@end

//
//  FJCommentReply.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJUser.h"

@interface FJCommentReply : NSObject
/** 回复哪个用户的模型 */
@property (nonatomic , strong) FJUser *user;

/** 要回复的id */
@property (nonatomic , copy) NSString *commentReplyId;

/** 话题内容 */
@property (nonatomic, copy) NSString *text;

/** 是否是回复 */
@property (nonatomic, assign , getter = isReply) BOOL reply;

@end

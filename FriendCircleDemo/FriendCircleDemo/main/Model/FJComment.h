//
//  FJComment.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FJUser;
@interface FJComment : NSObject

/** 评论、回复id */
@property (nonatomic , copy) NSString * commentId;

/** 创建时间 */
@property (nonatomic , copy) NSString *time;

/** 回复用户模型 */
@property (nonatomic , strong) FJUser *toUser;

/** 来源用户模型 */
@property (nonatomic , strong) FJUser *fromUser;

/** 话题内容 */
@property (nonatomic, copy) NSString *text;

/** 获取富文本 */
- (NSAttributedString *)attributedText;

@end

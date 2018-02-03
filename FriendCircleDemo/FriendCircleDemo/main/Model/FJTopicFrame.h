//
//  FJTopicFrame.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FJTopic,FJCommentFrame;

@interface FJTopicFrame : NSObject

/** 头像frame */
@property (nonatomic , assign , readonly) CGRect avatarFrame;

/** 昵称frame */
@property (nonatomic , assign , readonly) CGRect nicknameFrame;
/** 点赞frame */
@property (nonatomic , assign , readonly) CGRect thumbFrame;

/** 更多frame */
@property (nonatomic , assign , readonly) CGRect moreFrame;

/** 时间frame */
@property (nonatomic , assign , readonly) CGRect createTimeFrame;

/** 评论frame */
@property (nonatomic , assign , readonly) CGRect reviewFrame;

/** 话题内容frame */
@property (nonatomic , assign , readonly) CGRect textFrame;
/** 图片内容frame */
@property (nonatomic,assign,readonly) CGRect picsFrame;

/** 赞frame */
@property (nonatomic,assign,readonly) CGRect likesBaseFrame;

@property (nonatomic,assign,readonly) CGRect likesFrame;

/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign , readonly) CGFloat height;
/** 内容尺寸 */
@property (nonatomic , assign , readonly) CGRect cellFrame;
/** cell高度 */
@property (nonatomic , assign , readonly) CGFloat cellHeight;

@property (nonatomic , strong) FJCommentFrame *commentFrame;

@property (nonatomic , assign) CGMutablePathRef trianglePath;

@property (nonatomic,strong) NSMutableArray *commentFrameArray;

/** 话题模型 */
@property (nonatomic , strong) FJTopic *topic;



@end

//
//  FJTopicFrame.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJTopicFrame.h"
#import "FJCommentFrame.h"
#import "FJTopic.h"


@interface FJTopicFrame ()

/** 头像frame */
@property (nonatomic , assign) CGRect avatarFrame;

/** 昵称frame */
@property (nonatomic , assign) CGRect nicknameFrame;
/** 点赞frame */
@property (nonatomic , assign) CGRect thumbFrame;

/** 更多frame */
@property (nonatomic , assign) CGRect moreFrame;

/** 时间frame */
@property (nonatomic , assign) CGRect createTimeFrame;

/** 评论frame */
@property (nonatomic , assign) CGRect reviewFrame;

/** 话题内容frame */
@property (nonatomic , assign) CGRect textFrame;

@property (nonatomic,assign) CGRect cellFrame;
/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;

/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign) CGFloat height;

@end

@implementation FJTopicFrame

- (instancetype)init
{
    self = [super init];
    if (self) {
        _commentFrameArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)setTopic:(FJTopic *)topic{
    _topic = topic;
    CGFloat width = FJMainScreenWidth;
    // 头像
    CGFloat avatarX = FJTopicHorizontalSpace;
    CGFloat avatarY = FJTopicVerticalSpace;
    CGFloat avatarW = FJTopicAvatarWH;
    CGFloat avatarH = FJTopicAvatarWH;
    self.avatarFrame = CGRectMake(avatarX, avatarY, avatarW, avatarH);
    
    // 布局更多
    CGFloat moreW = FJTopicMoreButtonW;
    CGFloat moreX = width - moreW;
    CGFloat moreH = avatarH * .5f;
    CGFloat moreY = avatarY+(avatarH-moreH)/2;
    self.moreFrame = CGRectMake(moreX, moreY, moreW, moreH);
    
    // 布局点赞按钮
    CGFloat thumbW = topic.thumbNumsString?([topic.thumbNumsString widthForFont:FJTopicThumbFont] + 30):44;
    CGFloat thumbX = CGRectGetMinX(self.moreFrame) - thumbW;
    CGFloat thumbY = avatarY+(avatarH-moreH)/2;
    CGFloat thumbH = moreH;
    self.thumbFrame = CGRectMake(thumbX, thumbY, thumbW, thumbH);
    
    //昵称
    CGFloat nickNameX = CGRectGetMaxX(self.avatarFrame)+FJTopicHorizontalSpace;
    CGFloat nickNameY = avatarY+(avatarH-moreH)/2;
    CGFloat nickNameW = CGRectGetMinX(self.thumbFrame) - nickNameX;
    CGFloat nickNameH = moreH;
    self.nicknameFrame = CGRectMake(nickNameX, nickNameY, nickNameW, nickNameH);
    
    //内容
    CGFloat contentX = nickNameX;
    CGSize limitSize = CGSizeMake(width-contentX-FJTopicHorizontalSpace, MAXFLOAT);
    CGFloat contentY = CGRectGetMaxY(self.avatarFrame);
    CGFloat contentW = limitSize.width;
    CGFloat contentH = [YYTextLayout layoutWithContainerSize:limitSize text:topic.attributedText].textBoundingSize.height+2*FJTopicVerticalSpace;
    self.textFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    
    // 时间
    CGFloat timeX = nickNameX;
    CGFloat timeY = CGRectGetMaxY(self.textFrame);
    CGFloat timeW = width*0.4;
    CGFloat timeH = moreH;
    self.createTimeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    //评论
    CGFloat reviewX = width - moreW - 2*FJTopicHorizontalSpace;
    CGFloat reviewY = CGRectGetMaxY(self.textFrame);
    CGFloat reviewW = moreH;
    CGFloat reviewH = moreH;
    
    self.reviewFrame = CGRectMake(reviewX, reviewY, reviewW, reviewH);
    
    self.height = CGRectGetMaxY(self.createTimeFrame)+FJTopicVerticalSpace;
    
    if (topic.commentArray.count > 0) {
        [self.commentFrameArray removeAllObjects];
        [topic.commentArray enumerateObjectsUsingBlock:^(FJComment *comment, NSUInteger idx, BOOL * _Nonnull stop) {
            FJCommentFrame *commentFrame = [[FJCommentFrame alloc]init];
            commentFrame.comment = comment;
            [self.commentFrameArray addObject:commentFrame];
        }];
    }
}



































@end

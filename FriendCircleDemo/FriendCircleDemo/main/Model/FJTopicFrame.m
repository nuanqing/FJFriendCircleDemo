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
/** 图片内容frame */
@property (nonatomic,assign) CGRect picsFrame;
/** 赞frame */
@property (nonatomic,assign) CGRect likesBaseFrame;

@property (nonatomic,assign) CGRect likesFrame;

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
    
    //图片内容
    if (topic.picArray.count > 0) {
        long perRowItemCount = [self _perRowItemCountForPicArry:topic.picArray];
        CGFloat picX = nickNameX;
        CGFloat picY = CGRectGetMaxY(self.textFrame);
        CGFloat picWH = [self _picWHForPicArray:topic.picArray];
        CGFloat margin = FJTopicHorizontalSpace/2;
        int columnCount = ceilf(topic.picArray.count * 1.0 / perRowItemCount);
        CGFloat picsH = columnCount * picWH + (columnCount - 1) * margin;
        CGFloat picsW = contentW;
        self.picsFrame = CGRectMake(picX, picY, picsW, picsH);
    }
    
    // 时间
    CGFloat timeX = nickNameX;
    CGFloat timeY;
    if (topic.picArray.count > 0) {
        timeY = CGRectGetMaxY(self.picsFrame)+FJTopicVerticalSpace;
    }else{
        timeY = CGRectGetMaxY(self.textFrame)+FJTopicVerticalSpace;
    }
    CGFloat timeW = width*0.4;
    CGFloat timeH = moreH;
    self.createTimeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    //评论
    CGFloat reviewX = width - moreW - 2*FJTopicHorizontalSpace;
    CGFloat reviewY = timeY;
    CGFloat reviewW = moreH;
    CGFloat reviewH = moreH;
    self.reviewFrame = CGRectMake(reviewX, reviewY, reviewW, reviewH);
    
    //赞
    if (topic.likesArray.count>0) {
        CGFloat likesBaseX = nickNameX;
        CGSize likesBaseLimitSize = CGSizeMake(width-likesBaseX-FJTopicHorizontalSpace, MAXFLOAT);
        CGFloat likesBaseY =  CGRectGetMaxY(self.createTimeFrame)+FJTopicVerticalSpace;
        CGFloat likesBaseW = limitSize.width;
        CGFloat likesBaseH = [YYTextLayout layoutWithContainerSize:likesBaseLimitSize text:topic.attributedLikes].textBoundingSize.height+2*FJTopicVerticalSpace;
        self.likesBaseFrame = CGRectMake(likesBaseX, likesBaseY, likesBaseW, likesBaseH);
        
        CGFloat likesX = nickNameX+FJTopicHorizontalSpace/2;
        CGSize likesLimitSize = CGSizeMake((width-likesX)-FJTopicHorizontalSpace*1.5, MAXFLOAT);
        CGFloat likesY =  likesBaseY;
        CGFloat likesW = likesLimitSize.width;
        CGFloat likesH = [YYTextLayout layoutWithContainerSize:likesLimitSize text:topic.attributedLikes].textBoundingSize.height+2*FJTopicVerticalSpace;
        self.likesFrame = CGRectMake(likesX, likesY, likesW, likesH);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, likesBaseX+FJTopicHorizontalSpace, likesBaseY);
        CGPathAddLineToPoint(path, nil, likesBaseX+FJTopicHorizontalSpace*1.5, likesBaseY-FJTopicHorizontalSpace*0.8);
        CGPathAddLineToPoint(path, nil, likesBaseX+FJTopicHorizontalSpace*2, likesBaseY);
        CGPathCloseSubpath(path);
        self.trianglePath = path;
       
    }else{
         self.likesBaseFrame = CGRectZero;
        self.likesFrame = CGRectZero;
        self.trianglePath = nil;
    }
    
    //高度
    if (topic.likesArray.count>0) {
        self.height = CGRectGetMaxY(self.likesBaseFrame)+FJTopicVerticalSpace/4;
    }else{
        self.height = CGRectGetMaxY(self.createTimeFrame)+FJTopicVerticalSpace;
    };
}

- (NSInteger)_perRowItemCountForPicArry:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)_picWHForPicArray:(NSArray *)array{
    if (array.count == 1) {
        return FJTopicOnePicWH;
    }
    return FJTopicMorePicWH;
}





























@end

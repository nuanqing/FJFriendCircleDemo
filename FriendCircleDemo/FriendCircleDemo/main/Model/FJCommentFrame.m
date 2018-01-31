//
//  FJCommentFrame.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJCommentFrame.h"

@interface FJCommentFrame()

@property (nonatomic,assign) CGRect textFrame;
/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;
@end

@implementation FJCommentFrame


- (void)setComment:(FJComment *)comment{
    _comment = comment;
    CGFloat contentX = FJCommentHorizontalSpace;
    CGFloat contentY = FJCommentVerticalSpace;
    CGSize contentLimitSize = CGSizeMake((FJMainScreenWidth - FJTopicHorizontalSpace*3-FJTopicAvatarWH)-2*FJCommentHorizontalSpace, MAXFLOAT);
    CGFloat contentW = contentLimitSize.width;
    CGFloat contentH = [YYTextLayout layoutWithContainerSize:contentLimitSize text:_comment.attributedText].textBoundingSize.height;
    self.textFrame = CGRectMake(contentX, contentY, contentW, contentH);
    self.cellHeight = CGRectGetMaxY(self.textFrame) + FJCommentVerticalSpace;
    
}

@end

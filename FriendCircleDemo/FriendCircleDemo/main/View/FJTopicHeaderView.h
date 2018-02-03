//
//  FJTopicHeaderView.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJTopic,FJTopicHeaderView,FJTopicFrame,FJUser;

@protocol FJTopicHeaderViewDelegate<NSObject>

/** 点击头像 */
- (void)topicHeaderViewAvatarDidClicked:(FJTopicHeaderView *)topicHeaderView;

/** 点击昵称 */
- (void)topicHeaderViewNickNameDidClicked:(FJUser *)user;

/** 点击更多按钮 */
- (void)topicHeaderViewMoreClicked:(FJTopicHeaderView *)topicHeaderView;

/** 点击点赞按钮 */
- (void)topicHeaderViewThumbClicked:(FJTopicHeaderView *)topicHeaderView;
/** 点击内容*/
- (void)topicHeaderViewContentClicked:(FJTopicHeaderView *)topicHeaderView;
/** 点击评论*/
- (void)topicHeaderViewCommentClicked:(FJTopicHeaderView *)topicHeaderView;

/** 点击手机号，网址 */
- (void)topicHeaderViewMobileOrWebClicked:(NSString *)text;

@end

@interface FJTopicHeaderView : UITableViewHeaderFooterView
/**
 复用HeaderView
 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) FJTopicFrame *topicFrame;

@property (nonatomic,strong) FJTopic *topic;

@property (nonatomic,weak) id<FJTopicHeaderViewDelegate> delegate;

@end

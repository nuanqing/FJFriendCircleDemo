//
//  FJCommentCell.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJCommentFrame,FJComment,FJUser;

@protocol FJCommentCellDelegate<NSObject>

- (void)commentCellUserClicked:(FJUser *)user;

- (void)commentCellMobileOrWebClicked:(NSString *)text;

@end

@interface FJCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;


/** 评论Frame */
@property (nonatomic , strong) FJCommentFrame *commentFrame;

@property (nonatomic,strong) FJComment *comment;

@property (nonatomic,weak) id<FJCommentCellDelegate> delegate;

@end

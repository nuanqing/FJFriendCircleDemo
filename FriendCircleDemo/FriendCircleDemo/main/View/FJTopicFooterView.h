//
//  FJTopicFooterView.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJTopicFooterView : UITableViewHeaderFooterView
/**
 复用footerView
 @param tableView tableView
 @return header
 */
+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

- (void)setSection:(NSInteger)section allSections:(NSInteger)sections;

@end

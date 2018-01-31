//
//  FJCommentFrame.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJComment.h"

@interface FJCommentFrame : NSObject
/** 内容尺寸 */
@property (nonatomic , assign , readonly) CGRect textFrame;
/** cell高度 */
@property (nonatomic , assign , readonly) CGFloat cellHeight;

/** 评论模型 外界传递 */
@property (nonatomic , strong) FJComment *comment;

@end

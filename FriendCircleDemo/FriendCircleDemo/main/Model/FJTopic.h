//
//  FJTopic.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FJUser,FJComment;

@interface FJTopic : NSObject

/** 视频的id */
@property (nonatomic , copy) NSString *mediabase_id;
/** 话题id */
@property (nonatomic , copy) NSString * topicId;

/** 点赞数 */
@property (nonatomic , assign) long long thumbNums;

/** 点赞数string //辅助属性// */
@property (nonatomic , copy , readonly) NSString * thumbNumsString;

/** 是否点赞  0 没有点赞 1 是点赞*/
@property (nonatomic , assign , getter = isThumb) BOOL thumb;

/** 创建时间 */
@property (nonatomic , copy) NSString *creatTime;

/** 话题内容 */
@property (nonatomic, copy) NSString *text;

/** 用户模型 */
@property (nonatomic,strong) FJUser *user;

@property (nonatomic,strong) FJComment *comment;

@property (nonatomic,strong) NSMutableArray *commentArray;

- (NSAttributedString *)attributedNickName;

/** 富文本 */
- (NSAttributedString *)attributedText;

@end

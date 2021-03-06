//
//  FJTopic.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJTopic.h"
#import "FJComment.h"
#import "FJUser.h"

@interface FJTopic ()

/** 点赞数string */
@property (nonatomic , copy) NSString * thumbNumsString;

@end
@implementation FJTopic

- (instancetype)init
{
    self = [super init];
    if (self) {
        _picArray = [[NSMutableArray alloc]init];
        _likesArray = [[NSMutableArray alloc]init];
        _commentArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSAttributedString *)attributedText
{
    if (self.text == nil) return nil;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    attributedString.font = FJFont(15.f, NO);
    attributedString.color = FJGlobalGrayTextColor;
    attributedString.lineSpacing = FJCommentContentLineSpacing;
    
   NSMutableArray *mobileTextArray = [FJRegularExpressionManager matchMobileLink:self.text];
    
    [mobileTextArray enumerateObjectsUsingBlock:^(NSString *mobileText, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [self.text rangeOfString:mobileText];
        YYTextHighlight *mobileTextHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
        mobileTextHighlight.userInfo = @{FJMobileOrWebTextKey:mobileText};
        [attributedString setTextHighlight:mobileTextHighlight range:range];
        [attributedString setColor:FJGlobalOrangeTextColor range:range];
       
    }];
    
   NSMutableArray *webTextArray = [FJRegularExpressionManager matchWebLink:self.text];
    [webTextArray enumerateObjectsUsingBlock:^(NSString *webText, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [self.text rangeOfString:webText];
        YYTextHighlight *webTextHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
        webTextHighlight.userInfo = @{FJMobileOrWebTextKey:webText};
        [attributedString setTextHighlight:webTextHighlight range:range];
        [attributedString setColor:FJGlobalOrangeTextColor range:range];
        
    }];
    
    
    return attributedString;
}

- (NSAttributedString *)attributedNickName{
    
    if (FJStringIsEmpty(self.user.nickname)) return nil;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.user.nickname];
    attributedString.font = FJTopicNicknameFont;
    attributedString.color = FJGlobalOrangeTextColor;
    
    NSRange range = NSMakeRange(0, self.user.nickname.length);
    YYTextHighlight *userHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
    [attributedString setTextHighlight:userHighlight range:range];
    
    return attributedString;
}

- (NSAttributedString *)attributedLikes{
    
     if (self.likesArray.count == 0) return nil;
    __block NSString *likesString = [[NSString alloc]init];
    __block NSMutableAttributedString *attributedString = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:@"like_nor"] contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(16, 16) alignToFont:FJCommentTextFont alignment:YYTextVerticalAlignmentCenter];
   
    [self.likesArray enumerateObjectsUsingBlock:^(FJUser *user, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            likesString = [NSString stringWithFormat:@" %@",user.nickname];
        }else{
            likesString = [likesString stringByAppendingString:[NSString stringWithFormat:@",%@",user.nickname]];
        }
    }];
    [attributedString appendAttributedString:[[NSMutableAttributedString alloc]initWithString:likesString]];
    
    [self.likesArray enumerateObjectsUsingBlock:^(FJUser *user, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [likesString rangeOfString:user.nickname];
        YYTextHighlight *userHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
        userHighlight.userInfo = @{FJUserKey:user};
        [attributedString setTextHighlight:userHighlight range:NSMakeRange(range.location+1, range.length)];
        [attributedString setColor:FJGlobalOrangeTextColor range:NSMakeRange(range.location+1, range.length)];
    }];
    
    return attributedString;
}


- (void)setThumbNums:(long long)thumbNums
{
    _thumbNums = thumbNums;
    if (!_thumbNums) {
        return;
    }
    self.thumbNumsString = [NSString stringWithFormat:@"%lld 万",_thumbNums];
}



@end

//
//  FJComment.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJComment.h"
#import "FJUser.h"

@implementation FJComment

- (NSAttributedString *)attributedText{
    if (FJStringIsNotEmpty(self.toUser.nickname)) {
        NSString *textString = [NSString stringWithFormat:@"%@回复了%@: %@",self.fromUser.nickname, self.toUser.nickname,self.text];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:textString];
        attributedString.font = FJCommentTextFont;
        attributedString.color = FJGlobalBlackTextColor;
        attributedString.lineSpacing = FJCommentContentLineSpacing;
        
        NSRange fromUserRange = NSMakeRange(0, self.fromUser.nickname.length);
        YYTextHighlight *fromUserHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
        fromUserHighlight.userInfo = @{FJCommentUserKey:self.fromUser};
        [attributedString setTextHighlight:fromUserHighlight range:fromUserRange];
        [attributedString setColor:FJGlobalOrangeTextColor range:fromUserRange];
        
        NSRange toUserRange = [textString rangeOfString:self.toUser.nickname];
        YYTextHighlight *toUserHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
        toUserHighlight.userInfo = @{FJCommentUserKey:self.toUser};
        [attributedString setTextHighlight:toUserHighlight range:toUserRange];
        [attributedString setColor:FJGlobalOrangeTextColor range:toUserRange];
        
        NSMutableArray *mobileTextArray = [FJRegularExpressionManager matchMobileLink:textString];
        
        [mobileTextArray enumerateObjectsUsingBlock:^(NSString *mobileText, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([mobileText isEqualToString:self.fromUser.nickname]||[mobileText isEqualToString:self.toUser.nickname]) return ;
            NSRange range = [textString rangeOfString:mobileText];
            YYTextHighlight *mobileTextHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
            mobileTextHighlight.userInfo = @{FJMobileOrWebTextKey:mobileText};
            [attributedString setTextHighlight:mobileTextHighlight range:range];
            [attributedString setColor:FJGlobalOrangeTextColor range:range];
            
        }];
        
        NSMutableArray *webTextArray = [FJRegularExpressionManager matchWebLink:textString];
        [webTextArray enumerateObjectsUsingBlock:^(NSString *webText, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([webText isEqualToString:self.fromUser.nickname]||[webText isEqualToString:self.toUser.nickname]) return ;
            NSRange range = [textString rangeOfString:webText];
            YYTextHighlight *webTextHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
            webTextHighlight.userInfo = @{FJMobileOrWebTextKey:webText};
            [attributedString setTextHighlight:webTextHighlight range:range];
            [attributedString setColor:FJGlobalOrangeTextColor range:range];
            
        }];
        
        return attributedString;
    }else{
        NSString *textString = [NSString stringWithFormat:@"%@: %@",self.fromUser.nickname,self.text];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:textString];
        attributedString.font = FJCommentTextFont;
        attributedString.color = FJGlobalBlackTextColor;
        attributedString.lineSpacing = FJCommentContentLineSpacing;
        
        NSRange fromUserRange = NSMakeRange(0, self.fromUser.nickname.length);
        YYTextHighlight *fromUserHighlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]];
        fromUserHighlight.userInfo = @{FJCommentUserKey:self.fromUser};
        [attributedString setTextHighlight:fromUserHighlight range:fromUserRange];
        [attributedString setColor:FJGlobalOrangeTextColor range:fromUserRange];
        
        
        NSMutableArray *mobileTextArray = [FJRegularExpressionManager matchMobileLink:textString];
        
        [mobileTextArray enumerateObjectsUsingBlock:^(NSString *mobileText, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([mobileText isEqualToString:self.fromUser.nickname]||[mobileText isEqualToString:self.toUser.nickname]) return ;
            NSRange range = [textString rangeOfString:mobileText];
            YYTextHighlight *mobileTextHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
            mobileTextHighlight.userInfo = @{FJMobileOrWebTextKey:mobileText};
            [attributedString setTextHighlight:mobileTextHighlight range:range];
            [attributedString setColor:FJGlobalOrangeTextColor range:range];
            
        }];
        
        NSMutableArray *webTextArray = [FJRegularExpressionManager matchWebLink:textString];
        [webTextArray enumerateObjectsUsingBlock:^(NSString *webText, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([webText isEqualToString:self.fromUser.nickname]||[webText isEqualToString:self.toUser.nickname]) return ;
            NSRange range = [textString rangeOfString:webText];
            YYTextHighlight *webTextHighlight = [YYTextHighlight highlightWithBackgroundColor:FJGlobalHighLightColor];
            webTextHighlight.userInfo = @{FJMobileOrWebTextKey:webText};
            [attributedString setTextHighlight:webTextHighlight range:range];
            [attributedString setColor:FJGlobalOrangeTextColor range:range];
            
        }];
        
        return attributedString;
    }
    return nil;
}

@end

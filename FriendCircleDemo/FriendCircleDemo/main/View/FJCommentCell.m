//
//  FJCommentCell.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJCommentCell.h"
#import "FJCommentFrame.h"
#import "FJUser.h"

@interface FJCommentCell()

@property (nonatomic,strong) YYLabel *contentLabel;

@end

@implementation FJCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"commentCell";
    FJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = FJGlobalGrayBackgroundColor;
        self.contentView.backgroundColor = FJGlobalGrayBackgroundColor;
        [self setupUI];
    }
    return self;
}
#pragma mark - override
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = FJTopicAvatarWH+2*FJTopicHorizontalSpace;
    frame.size.width = FJMainScreenWidth - frame.origin.x - FJTopicHorizontalSpace;
    [super setFrame:frame];
}


- (void)setCommentFrame:(FJCommentFrame *)commentFrame{
    
    self.contentLabel.frame = commentFrame.textFrame;
    
}

- (void)setComment:(FJComment *)comment{
    _comment = comment;
     self.contentLabel.attributedText = comment.attributedText;
}

- (void)setupUI{
    self.contentLabel = [[YYLabel alloc]init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.contentLabel];
    
    FJWeakSelf(self)
    self.contentLabel.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        YYTextHighlight *highLight = [text attribute:YYTextHighlightAttributeName atIndex:range.location];
        //用户
        if (highLight.userInfo[FJCommentUserKey]) {
            [weakself cellUserClicked:highLight];
        }else{
            [weakself cellMobileOrWebClicked:highLight];
        }
    };
    
}

- (void)cellUserClicked:(YYTextHighlight *)highLight{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentCellUserClicked:)]) {
        [self.delegate commentCellUserClicked:highLight.userInfo[FJCommentUserKey]];
    }
}

- (void)cellMobileOrWebClicked:(YYTextHighlight *)highLight{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentCellMobileOrWebClicked:)]) {
        [self.delegate commentCellMobileOrWebClicked:highLight.userInfo[FJMobileOrWebTextKey]];
    }
}










@end

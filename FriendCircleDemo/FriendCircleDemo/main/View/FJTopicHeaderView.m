//
//  FJTopicHeaderView.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJTopicHeaderView.h"
#import "FJTopicPicsView.h"
#import "FJTopicFrame.h"
#import "FJTopic.h"
#import "FJUser.h"

@interface FJTopicHeaderView()

/** 头像 */
@property (nonatomic,strong) UIImageView *avatarView;

@property (nonatomic,strong) CALayer *avatarLayer;

/** 昵称 */
@property (nonatomic,strong) YYLabel *nicknameLable;

/** 点赞 */
@property (nonatomic,strong) UIButton *thumbBtn;

/** 更多 */
@property (nonatomic,strong) UIButton *moreBtn;

/** 创建时间 */
@property (nonatomic,strong) YYLabel *createTimeLabel;

/** 评论按钮 */
@property (nonatomic,strong) UIButton *reviewButton;

/** 图片内容 */
@property (nonatomic,strong) FJTopicPicsView *topicPicsView;
/** 赞 */
@property (nonatomic,strong) UIView *likesBaseView;

@property (nonatomic,strong) YYLabel *likesLable;
/** 文本内容 */
@property (nonatomic , strong) YYLabel *contentLabel;


@end

@implementation FJTopicHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"topicHeader";
    FJTopicHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:indentifier];
    if (!header) {
        header = [[self alloc]initWithReuseIdentifier:indentifier];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setTopicFrame:(FJTopicFrame *)topicFrame{
    _topicFrame = topicFrame;
    
     //头像
    self.avatarView.frame = _topicFrame.avatarFrame;
    
    self.avatarLayer.frame = self.avatarView.bounds;
    self.avatarLayer.cornerRadius = self.avatarView.height / 2;
    self.avatarLayer.shouldRasterize = YES;
    self.avatarLayer.rasterizationScale = kScreenScale;
    // 昵称
    self.nicknameLable.frame = _topicFrame.nicknameFrame;
    // 点赞
    self.thumbBtn.frame = _topicFrame.thumbFrame;
    // 更多
    self.moreBtn.frame = _topicFrame.moreFrame;
    // 时间
    self.createTimeLabel.frame = _topicFrame.createTimeFrame;
    //评论
    self.reviewButton.frame = _topicFrame.reviewFrame;
    // 内容
    self.contentLabel.frame = _topicFrame.textFrame;
    //图片
    self.topicPicsView.frame = _topicFrame.picsFrame;
    
    self.likesBaseView.frame = _topicFrame.likesBaseFrame;
    
    self.likesLable.frame = _topicFrame.likesFrame;
}

- (void)setTopic:(FJTopic *)topic{
    _topic = topic;
    // 头像
    UIImage *image = FJGlobalUserDefaultAvatar;
    [self.avatarView setImageWithURL:[NSURL URLWithString:_topic.user.avatarUrl] placeholder:[image imageByRoundCornerRadius:image.size.width/2] options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        //圆角
        //image = [image imageByResizeToSize:CGSizeMake(200, 200)];
        return [image imageByRoundCornerRadius:image.size.width/2];
    } completion:nil];
    
    //昵称
    self.nicknameLable.attributedText = _topic.attributedNickName;
    //点赞
    [self.thumbBtn setTitle:_topic.thumbNumsString forState:UIControlStateNormal];
    self.thumbBtn.selected = _topic.isThumb;
    //时间
    self.createTimeLabel.text = _topic.creatTime;
    
    //内容
    self.contentLabel.attributedText = _topic.attributedText;
    //图片
    [self.topicPicsView imageViewForPicArray:_topic.picArray];
    
    self.likesLable.attributedText = _topic.attributedLikes;
}



- (void)setupUI{
    
    FJWeakSelf(self);
    //头像
    self.avatarView = [[UIImageView alloc]init];
    self.avatarView.backgroundColor = [UIColor clearColor];
    self.avatarView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.avatarView];
    
    self.avatarLayer = [CALayer layer];
    self.avatarLayer.borderWidth = CGFloatFromPixel(1);
    self.avatarLayer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    [self.avatarView.layer addSublayer:self.avatarLayer];
    
    UITapGestureRecognizer *avatarTaped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarDidClicked)];
    [self.avatarView addGestureRecognizer:avatarTaped];
    
    
    self.nicknameLable = [[YYLabel alloc]init];
    self.nicknameLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nicknameLable];
    
    self.nicknameLable.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakself nicknameDidClicked:weakself.topic.user];
    };
    
    // 点赞按钮
    self.thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thumbBtn.adjustsImageWhenHighlighted = NO;
    [self.thumbBtn setImage:FJImageNamed(@"comment_zan_nor") forState:UIControlStateNormal];
    [self.thumbBtn setImage:FJImageNamed(@"comment_zan_high") forState:UIControlStateSelected];
    [self.thumbBtn setTitleColor:FJGlobalGrayTextColor forState:UIControlStateNormal];
    [self.thumbBtn addTarget:self action:@selector(thumbBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.thumbBtn.titleLabel.font = FJTopicThumbFont;
    [self.contentView addSubview:self.thumbBtn];

    //更多
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setImage:FJImageNamed(@"comment_more") forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    //时间
    self.createTimeLabel = [[YYLabel alloc]init];
    self.createTimeLabel.text = @"";
    self.createTimeLabel.font = FJTopicNicknameFont;
    self.createTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.createTimeLabel.textColor = FJGlobalGrayTextColor;
    [self.contentView addSubview:self.createTimeLabel];
    //评论按钮
    self.reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reviewButton setImage:FJImageNamed(@"review_nor") forState:UIControlStateNormal];
    [self.reviewButton addTarget:self action:@selector(commentImageViewTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.reviewButton];
    
    
    //文本
    self.contentLabel = [[YYLabel alloc] init];
    // 设置文本的额外区域，修复用户点击文本没有效果
    UIEdgeInsets textContainerInset = self.contentLabel.textContainerInset;
    textContainerInset.top = FJTopicVerticalSpace;
    textContainerInset.bottom = FJTopicVerticalSpace;
    self.contentLabel.textContainerInset = textContainerInset;
    
    self.contentLabel.numberOfLines = 0 ;
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakself contentDidClicked];
    };
    self.contentLabel.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
         YYTextHighlight *highLight = [text attribute:YYTextHighlightAttributeName atIndex:range.location];
        [weakself MobileOrWebClicked:highLight];
    };
    
    self.topicPicsView = [[FJTopicPicsView alloc]init];
    [self.contentView addSubview:self.topicPicsView];
    
    //赞
    
    self.likesBaseView = [[UIView alloc]init];
    self.likesBaseView.backgroundColor = FJGlobalGrayBackgroundColor;
    self.likesBaseView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.likesBaseView];
    
    self.likesLable = [[YYLabel alloc]init];
    self.likesLable.numberOfLines = 0;
    self.likesLable.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:self.likesLable];
    
    self.likesLable.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            YYTextHighlight *highLight = [text attribute:YYTextHighlightAttributeName atIndex:range.location];
        [weakself nicknameDidClicked:highLight.userInfo[FJUserKey]];
        
    };
}

#pragma mark - 事件

- (void)avatarDidClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewAvatarDidClicked:)]) {
        [self.delegate topicHeaderViewAvatarDidClicked:self];
    }
}

- (void)nicknameDidClicked:(FJUser *)user{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewNickNameDidClicked:)]) {
        [self.delegate topicHeaderViewNickNameDidClicked:user];
    }
}

- (void)thumbBtnDidClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewThumbClicked:)]) {
        [self.delegate topicHeaderViewThumbClicked:self];
    }
}

- (void)moreBtnDidClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewMoreClicked:)]) {
        [self.delegate topicHeaderViewMoreClicked:self];
    }
}

- (void)contentDidClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewContentClicked:)]) {
        [self.delegate topicHeaderViewContentClicked:self];
    }
}

- (void)commentImageViewTaped{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewCommentClicked:)]) {
        [self.delegate topicHeaderViewCommentClicked:self];
    }
}

- (void)MobileOrWebClicked:(YYTextHighlight *)highLight{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderViewMobileOrWebClicked:)]) {
        [self.delegate topicHeaderViewMobileOrWebClicked:highLight.userInfo[FJMobileOrWebTextKey]];
    }
}


@end

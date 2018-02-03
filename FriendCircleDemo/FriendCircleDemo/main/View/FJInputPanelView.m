//
//  FJInputPanelView.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/27.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJInputPanelView.h"

@interface FJInputPanelView()<YYTextViewDelegate,YYTextKeyboardObserver>


@property (nonatomic,strong) FJLine *line;
@property (nonatomic,strong) UIButton *emoButton;
@property (nonatomic,assign ,getter=iskeyBoardShow) BOOL keyBoardShow;
@property (nonatomic,assign) CGFloat keyBoardHeight;

@end

@implementation FJInputPanelView

+ (instancetype)inputPanelView{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self setupSubViewsConstraints];
        [self setupObeserver];
    }
    return self;
}




- (void)setupUI{
    [self addSubview:self.line];
    [self addSubview:self.textView];
    [self addSubview:self.emoButton];
    
}


- (void)setupSubViewsConstraints{
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@(FJGlobalLineHeight));
    }];
    
    [self.emoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(FJTopicVerticalSpace);
        make.bottom.equalTo(self).with.offset(-FJTopicVerticalSpace);
        make.right.equalTo(self).with.offset(-FJTopicHorizontalSpace);
        make.width.equalTo(self.emoButton.mas_height);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.emoButton);
        make.left.equalTo(self).with.offset(FJTopicHorizontalSpace);
        make.right.equalTo(self.emoButton.mas_left).with.offset(-FJTopicHorizontalSpace);
    }];
}

- (void)setupObeserver{
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition{
    if (!(CGRectGetMinY(transition.toFrame)==FJMainScreenHeight)) {
        self.hidden = NO;
    }
    if (transition.animationDuration == 0) {
        if (!(CGRectGetMinY(transition.toFrame)==FJMainScreenHeight)) {
            self.bottom = CGRectGetMinY(transition.toFrame);
            [self keyBordShow];
        }else{
            self.bottom = CGRectGetMinY(transition.toFrame)+FJCommentInputHeight;
        }
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (!(CGRectGetMinY(transition.toFrame)==FJMainScreenHeight)) {
                self.bottom = CGRectGetMinY(transition.toFrame);
            }else{
                self.bottom = CGRectGetMinY(transition.toFrame)+FJCommentInputHeight;
            }

        } completion:^(BOOL finished) {
            if (finished) {
                if (CGRectGetMinY(transition.toFrame)==FJMainScreenHeight) {
                     self.hidden = YES;
                     self.textView.text = NULL;
                }else{
                    [self keyBordShow];
                }
            }
        }];
    }
}


#pragma mark–键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    // 开始尺寸
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    // 最终尺寸
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = ([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 ) | UIViewAnimationOptionBeginFromCurrentState;
         // 第三方键盘回调，监听仅执行最后一次
    if((beginFrame.origin.y-endFrame.origin.y>0)){
        if (!self.iskeyBoardShow) {
            self.hidden = NO;
            [UIView animateWithDuration:duration delay:0 options:options animations:^{
                self.bottom = CGRectGetMinY(endFrame);
                [self keyBordShow];
            } completion:^(BOOL finished) {
                 self.keyBoardShow = YES;
            }];
        }
    }
 }
#pragma mark–键盘隐藏事件

-(void)keyBoardDidHide:(NSNotification *)notification{

    NSDictionary *userInfo = notification.userInfo;
    // 动画时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = ([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 ) | UIViewAnimationOptionBeginFromCurrentState;
     [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.bottom = FJMainScreenHeight+FJNavHeight;
     }completion:^(BOOL finished) {
         self.hidden = YES;
         self.textView.text = NULL;
         self.keyBoardShow = NO;
     }];
    
}

- (void)keyBordShow{
    if (_delegate && [_delegate respondsToSelector:@selector(inputPanelViewKeyBoardShow:)]) {
        [_delegate inputPanelViewKeyBoardShow:self];
    }
}



#pragma mark - YYTextViewDelegate


//- (void)textViewDidBeginEditing:(YYTextView *)textView{
//    self.textView.text = NULL;
//}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self sendClick];
        return NO;
    }
    return YES;
}

- (void)sendClick{
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(textViewSendClicked)]) {
        [self.delegate textViewSendClicked];
    }
    
    [self.textView resignFirstResponder];
}

#pragma mark - 懒加载


- (YYTextView *)textView{
    if (!_textView) {
        _textView = [[YYTextView alloc]init];
        _textView.font = FJCommentTextFont;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.textColor = FJGlobalBlackTextColor;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.textContainerInset = UIEdgeInsetsMake(_textView.textContainerInset.top, 10, _textView.textContainerInset.bottom, 10) ;
        _textView.enablesReturnKeyAutomatically = YES;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = FJGlobalBottomLineColor.CGColor;
        _textView.backgroundColor = FJGlobalWhiteTextColor;
        _textView.placeholderFont = FJCommentTextFont;
        _textView.placeholderTextColor = FJGlobalGrayTextColor;
        _textView.delegate = self;
    }
    return _textView;
}

- (UIButton *)emoButton{
    if (!_emoButton) {
        _emoButton = [[UIButton alloc]init];
        _emoButton.backgroundColor = FJRandomColor;
    }
    return _emoButton;
}

- (UIView *)line{
    if (!_line) {
        _line = [FJLine line];
    }
    return _line;
}

- (void)dealloc{
     [[YYTextKeyboardManager defaultManager]removeObserver:self];
}

@end

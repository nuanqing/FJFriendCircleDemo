//
//  FJProgressHUD.m
//  FJProgressHUDDemo
//
//  Created by MacBook on 2018/2/5.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJProgressHUD.h"
#import "FJProgressHUDConfig.h"
#import "FJProgressHUDInfo.h"

@interface FJProgressHUD()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *textLabel;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) FJProgressHUDInfo *HUDInfo;

@property (nonatomic,strong) CAShapeLayer *HUDlayer;

@end

@implementation FJProgressHUD


#pragma mark - show(类方法)
//加载(指示器)
+ (FJProgressHUD *)showLoadingIndicatorText:(NSString *)text toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.showType = FJProgressHUDLoadingIndicator;
    hud.maskType = FJProgressHUDMaskTypeClear;
    [hud showToView:view];
    return hud;
}
//加载（圆环）
+ (FJProgressHUD *)showLoadingCircleText:(NSString *)text toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.showType = FJProgressHUDLoadingCircle;
    hud.maskType = FJProgressHUDMaskTypeClear;
    [hud showToView:view];
    return hud;
}
//进度(圆饼)
+ (FJProgressHUD *)showProgressCircleText:(NSString *)text toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.showType = FJProgressHUDProgressCircle;
    hud.maskType = FJProgressHUDMaskTypeClear;
    [hud showToView:view];
    return hud;
}
//状态(成功)
+ (void)showSuccessText:(NSString *)text toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.showType = FJProgressHUDStatusSuccess;
    hud.maskType = FJProgressHUDMaskTypeClear;
    hud.dissmissTime = 1.5;
    [hud showToView:view];
    
}
//状态(失败)
+ (void)showFailText:(NSString *)text toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.showType = FJProgressHUDStatusFail;
    hud.maskType = FJProgressHUDMaskTypeClear;
    hud.dissmissTime = 1.5;
    [hud showToView:view];
    
}
//自定义图片
+ (FJProgressHUD *)showCustomText:(NSString *)text images:(NSArray *)images toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.images = images;
    hud.showType = FJProgressHUDCustom;
    hud.maskType = FJProgressHUDMaskTypeClear;
    [hud showToView:view];
    return hud;
}

+ (FJProgressHUD *)showCustomText:(NSString *)text images:(NSArray *)images width:(CGFloat)width height:(CGFloat)height toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.width = width;
    hud.height = height;
    hud.images = images;
    hud.showType = FJProgressHUDCustom;
    hud.maskType = FJProgressHUDMaskTypeClear;
    [hud showToView:view];
    return hud;
}

//只有文本
+(void)showOnlyText:(NSString *)text toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.text = text;
    hud.modeType = FJProgressHUDModeOnlyText;
    hud.dissmissTime = 1.5;
    [hud showToView:view];
}

//不显示文本
+(FJProgressHUD *)showOnlyHUDOrCustom:(FJProgressHUDShowType)showType images:(NSArray *)images toView:(UIView *)view{
    FJProgressHUD *hud = [self progressHUD];
    hud.images = images;
    hud.showType = showType;
    hud.maskType = FJProgressHUDMaskTypeClear;
    [hud showToView:view];
    return hud;
}

#pragma mark - init

+(instancetype)progressHUD{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self layoutFrame];
    }
    return self;
}

- (void)setupUI{
    self.alpha = 0;
    self.contentView.alpha = 1;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.textLabel];
    [self.contentView.layer addSublayer:self.HUDlayer];
    [self.contentView addSubview:self.indicatorView];
    
}


- (void)layoutFrame{
    self.frame = FJMainScreenBounds;
    self.textLabel.text = _text;
    self.HUDlayer.frame = self.HUDInfo.HUDFrame;
    self.contentView.frame = self.HUDInfo.contentViewFrame;
    self.textLabel.frame = self.HUDInfo.textLabelFrame;
    self.imageView.frame = self.HUDInfo.imageViewFrame;
    self.indicatorView.frame = self.HUDlayer.frame;
}

- (void)setText:(NSString *)text{
    _text = text;
    //指定默认模式 (hudinfo会判断文字是否为空)
    self.modeType = FJProgressHUDModeHudOrCustom;
}

- (void)setImages:(NSArray *)images{
    _images = images;
    //指定默认模式
    self.modeType = FJProgressHUDModeHudOrCustom;
}

- (void)setWidth:(CGFloat)width{
    _width = width;
    //指定默认模式
    self.modeType = FJProgressHUDModeHudOrCustom;
}

- (void)setHeight:(CGFloat)height{
    _height = height;
    //指定默认模式
    self.modeType = FJProgressHUDModeHudOrCustom;
}

- (void)setMaskType:(FJProgressHUDMaskType )maskType{
    _maskType = maskType;
    switch (maskType) {
        case FJProgressHUDMaskTypeNone:
            self.backgroundColor = [UIColor clearColor];
            break;
        case FJProgressHUDMaskTypeClear:
            self.backgroundColor = [UIColor clearColor];
            break;
        case FJProgressHUDMaskTypeGray:
            self.backgroundColor = [UIColor lightGrayColor];
            break;
    }
}

- (void)setModeType:(FJProgressHUDModeType )modeType{
    _modeType = modeType;
    switch (modeType) {
        case FJProgressHUDModeHudOrCustom:
            if (self.images.count>0) {
                if (!_width&&!_height) {
                    [self.HUDInfo layoutCustomWithText:_text];
                }else{
                    [self.HUDInfo layoutCustomWithText:_text Width:_width height:_height];
                }
            }else{
                [self.HUDInfo layoutHUDWithText:_text];
            }
            [self layoutFrame];
            break;
        case FJProgressHUDModeOnlyHudOrCustom:
            if (self.images.count>0) {
                [self.HUDInfo layoutOnlyCustom];
            }else{
                [self.HUDInfo layoutOnlyHUD];
            }
            [self layoutFrame];
            break;
        case FJProgressHUDModeOnlyText:
            [self.HUDInfo layoutOnlyTextWithText:_text];
            [self layoutFrame];
            break;
    }
    
}


- (void)setShowType:(FJProgressHUDShowType )showType{
    _showType = showType;
    [self.HUDlayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (showType == FJProgressHUDLoadingIndicator) {
        self.indicatorView.hidden = NO;
        self.HUDlayer.hidden = YES;
    }else{
        self.indicatorView.hidden = YES;
        self.HUDlayer.hidden = NO;
    }
    
    switch (showType) {
        case FJProgressHUDLoadingIndicator:
            [self.indicatorView startAnimating];
            break;//加载(指示器)
        case FJProgressHUDLoadingCircle:
            [self.HUDInfo drawLoadingCircle:self.HUDlayer];
            break;//加载（圆环）
        case FJProgressHUDProgressCircle:
            [self.HUDInfo drawProgressCircle:self.HUDlayer progress:_progress];
            break;//进度(圆饼)
        case FJProgressHUDStatusSuccess:
            [self.HUDInfo drawStatusSuccess:self.HUDlayer];
            break;//状态(成功)
        case FJProgressHUDStatusFail:
            [self.HUDInfo drawStatusFail:self.HUDlayer];
            break;//状态(失败)
        case FJProgressHUDCustom:
            [self imageViewSetImages:_images];
            break;//自定义
    }
}

- (void)setStyleType:(FJProgressHUDStyleType )styleType{
    _styleType = styleType;
    switch (styleType) {
        case FJProgressHUDStyleDark:
            self.contentView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.85];
            break;
        case FJProgressHUDStyleLight:
            self.contentView.backgroundColor = FJAlphaColor(234, 237, 239, 0.95);
            break;
    }
    
    UIColor *color = _styleType == FJProgressHUDStyleDark?[UIColor whiteColor]:[UIColor blackColor];
    self.textLabel.textColor = color;
    self.HUDlayer.strokeColor = color.CGColor;
    self.indicatorView.color = color;
}



- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (self.showType == FJProgressHUDProgressCircle) {
        [self.HUDInfo drawProgressCircle:self.HUDlayer progress:_progress];
    }
}

- (void)setCustomText:(NSString *)text images:(NSArray *)images width:(CGFloat)width height:(CGFloat)height{
    self.text = text;
    self.width = width;
    self.height = height;
    self.images = images;
    self.showType = FJProgressHUDCustom;
}

- (void)imageViewSetImages:(NSArray *)images{
    if (images.count == 0) return;
    if (_images.count == 1) {
        self.imageView.image = [UIImage imageNamed:[_images firstObject]];
    }else{
        NSMutableArray *imagesMutableArray = [NSMutableArray array];
        [_images enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL * _Nonnull stop) {
            [imagesMutableArray addObject:[UIImage imageNamed:imageName]];
        }];
        self.imageView.animationImages = imagesMutableArray;
        self.imageView.animationDuration = FJimageAnimationTime;
        self.imageView.animationRepeatCount = NSUIntegerMax;
        [self.imageView startAnimating];
    }
}

#pragma mark - show（实例方法）

- (void)showToView:(UIView *)view{
    if (!view||self.maskType == FJProgressHUDMaskTypeClear||self.maskType == FJProgressHUDMaskTypeGray){
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:self];
    }else{
        [view addSubview:self];
    }
    if (self.animationType == FJProgressHUDAnimationNormal) {
        [self showNormalAnimation];
    }else{
        [self showSpringAnimation];
    }
    if (self.dissmissTime == 0) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.dissmissTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
    
}
#pragma mark - showAnimation

- (void)showNormalAnimation{
    self.contentView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:FJAnimationTime animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
    }];
}

- (void)showSpringAnimation{
    self.contentView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:FJAnimationTime delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.9 options: UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
    } completion:nil];
}

#pragma mark - dismiss

- (void)dismiss{
    [UIView animateWithDuration:FJAnimationTime/2 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        self.contentView.alpha = 0;
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
#pragma mark - 懒加载

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.85];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = FJGlobalTextColor;
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]init];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
    return _indicatorView;
}

- (CAShapeLayer *)HUDlayer{
    if (!_HUDlayer) {
        _HUDlayer = [CAShapeLayer layer];
        _HUDlayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _HUDlayer;
}

- (FJProgressHUDInfo *)HUDInfo{
    if (!_HUDInfo) {
        _HUDInfo = [[FJProgressHUDInfo alloc]init];
    }
    return _HUDInfo;
}









@end


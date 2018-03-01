//
//  FJProgressHUD.h
//  FJProgressHUDDemo
//
//  Created by MacBook on 2018/2/5.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJProgressHUD;
/**
 样式
 */
typedef NS_ENUM(NSUInteger, FJProgressHUDShowType) {
    FJProgressHUDLoadingIndicator = 0,//加载(指示器)
    FJProgressHUDLoadingCircle = 1,//加载（圆环）
    FJProgressHUDProgressCircle = 2,//进度(圆饼)
    FJProgressHUDStatusSuccess = 3,//状态(成功)
    FJProgressHUDStatusFail = 4,//状态(失败)
    FJProgressHUDCustom = 5 //自定义
};
/**
 模式
 */
typedef NS_ENUM(NSUInteger, FJProgressHUDModeType) {
    FJProgressHUDModeHudOrCustom = 0,//显示所有
    FJProgressHUDModeOnlyText = 1,//只显示文本
    FJProgressHUDModeOnlyHudOrCustom = 2,//不显示文本
};
/**
 显示效果
 */
typedef NS_ENUM(NSUInteger, FJProgressHUDAnimationType) {
    FJProgressHUDAnimationNormal = 0,//普通效果
    FJProgressHUDAnimationSpring = 1//弹簧效果
};
/**
 背景颜色
 */
typedef NS_ENUM(NSInteger, FJProgressHUDStyleType) {
    FJProgressHUDStyleDark = 0,//背景颜色Dark
    FJProgressHUDStyleLight = 1//背景颜色Light
};
/**
 遮罩
 */
typedef NS_ENUM(NSInteger, FJProgressHUDMaskType) {
    FJProgressHUDMaskTypeNone = 0,//没有遮罩
    FJProgressHUDMaskTypeClear = 1,//透明遮罩
    FJProgressHUDMaskTypeGray = 2//灰色遮罩
};


@interface FJProgressHUD : UIView
/**
 样式
 */
@property (nonatomic,assign) FJProgressHUDShowType showType;
/**
 模式
 */
@property (nonatomic,assign) FJProgressHUDModeType modeType;
/**
 显示效果
 */
@property (nonatomic,assign) FJProgressHUDAnimationType animationType;
/**
 背景颜色
 */
@property (nonatomic,assign) FJProgressHUDStyleType styleType;
/**
 遮罩
 */
@property (nonatomic,assign) FJProgressHUDMaskType maskType;
//文本
@property (nonatomic,copy) NSString *text;
//图片宽度
@property (nonatomic,assign) CGFloat width;
//图片高度
@property (nonatomic,assign) CGFloat height;
//图片数组
@property (nonatomic,copy) NSArray *images;
//进度
@property (nonatomic,assign) CGFloat progress;
//结束时间
@property (nonatomic,assign) CGFloat dissmissTime;

#pragma mark - init

+(instancetype)progressHUD;

#pragma mark - show

/**
 加载（指示器）样式
 */
+ (FJProgressHUD *)showLoadingIndicatorText:(NSString *)text toView:(UIView *)view;
/**
 加载（圆环）样式
 */
+ (FJProgressHUD *)showLoadingCircleText:(NSString *)text toView:(UIView *)view;
/**
 进度（圆饼）样式
 */
+ (FJProgressHUD *)showProgressCircleText:(NSString *)text toView:(UIView *)view;
/**
 状态（成功）样式
 */
+ (void)showSuccessText:(NSString *)text toView:(UIView *)view;
/**
 状态（失败）样式
 */
+ (void)showFailText:(NSString *)text toView:(UIView *)view;
/**
 自定义（图片或动态图不指定宽高）样式
 */
+ (FJProgressHUD *)showCustomText:(NSString *)text images:(NSArray *)images toView:(UIView *)view;
/**
 自定义（图片或动态图指定宽高）样式
 */
+ (FJProgressHUD *)showCustomText:(NSString *)text images:(NSArray *)images width:(CGFloat)width height:(CGFloat)height toView:(UIView *)view;
/**
 只有文本 样式
 */
+(void)showOnlyText:(NSString *)text toView:(UIView *)view;
/**
 只有HUD或图片或动态图 样式
 */
+(FJProgressHUD *)showOnlyHUDOrCustom:(FJProgressHUDShowType)showType images:(NSArray *)images toView:(UIView *)view;
/**
 实例方法 方便
 */
- (void)setCustomText:(NSString *)text images:(NSArray *)images width:(CGFloat)width height:(CGFloat)height;

/**
 显示方法（不指定view在Window上显示）
 */
- (void)showToView:(UIView *)view;

#pragma mark - dismiss
/**
 隐藏方法
 */
- (void)dismiss;

@end


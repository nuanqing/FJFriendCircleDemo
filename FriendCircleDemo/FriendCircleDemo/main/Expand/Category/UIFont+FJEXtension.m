//
//  UIFont+FJEXtension.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "UIFont+FJEXtension.h"

/**
 *  极细体
 */
static NSString *const FJPingFangSC_Ultralight = @"PingFangSC-Ultralight";
/**
 *  常规体
 */
static NSString *const FJPingFangSC_Regular = @"PingFangSC-Regular";
/**
 *  中粗体
 */
static NSString *const FJPingFangSC_Semibold = @"PingFangSC-Semibold";
/**
 *  纤细体
 */
static NSString *const FJPingFangSC_Thin = @"PingFangSC-Thin";
/**
 *  细体
 */
static NSString *const FJPingFangSC_Light = @"PingFangSC-Light";
/**
 *  中黑体
 */
static NSString *const FJPingFangSC_Medium = @"PingFangSC-Medium";

@implementation UIFont (FJEXtension)
/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fj_fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:FJPingFangSC_Ultralight size:fontSize];
}

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fj_fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:FJPingFangSC_Regular size:fontSize];
}

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fj_fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:FJPingFangSC_Semibold size:fontSize];
}

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fj_fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:FJPingFangSC_Thin size:fontSize];
}

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fj_fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:FJPingFangSC_Light size:fontSize];
}

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fj_fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:FJPingFangSC_Medium size:fontSize];
}

@end

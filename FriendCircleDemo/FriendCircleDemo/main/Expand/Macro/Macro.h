//
//  Macro.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark - 尺寸

#define FJMainScreenBounds  [UIScreen mainScreen].bounds
#define FJMainScreenHeight  [UIScreen mainScreen].bounds.size.height
#define FJMainScreenWidth   [UIScreen mainScreen].bounds.size.width

#pragma mark - 系统
//app版本
#define FJAppVersion [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"]
//app名
#define FJAppName [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleDisplayName"]

// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%zd行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
// IOS版本
#define FJIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
// 销毁打印
#define FJDealloc NSLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

#pragma mark - 引用

//弱引用
#define FJWeakSelf(type)  __weak typeof(type) weak##type = type;
//强引用
#define FJStrongSelf(type)  __strong typeof(type) type = weak##type;

#pragma mark - 字体

#define FJFont(__size__,__bold__) ((__bold__)?([UIFont boldSystemFontOfSize:__size__]):([UIFont systemFontOfSize:__size__]))
// 中等
#define FJMediumFont(__size__)     ((FJIOSVersion<9.0)?FJFont(__size__ , YES):[UIFont fj_fontForPingFangSC_MediumFontOfSize:__size__])

// 常规
#define FJRegularFont(__size__)    ((FJIOSVersion<9.0)?FJFont(__size__ , NO):[UIFont fj_fontForPingFangSC_RegularFontOfSize:__size__])

/** 中粗体 */
#define FJSemiboldFont(__size__)   ((FJIOSVersion<9.0)?FJFont(__size__ , YES):[UIFont fj_fontForPingFangSC_SemiboldFontOfSize:__size__])

/**  话题内容字体大小 */
#define FJTopicTextFont FJMediumFont(12.0f)
/**  话题昵称字体大小 */
#define FJTopicNicknameFont FJMediumFont(13.0f)
/**  话题点赞字体大小 */
#define FJTopicThumbFont FJMediumFont(10.0f)
/**  话题时间字体大小 */
#define FJTopicCreateTimeFont FJMediumFont(10.0f)
/**  评论内容字体大小 */
#define FJCommentTextFont FJMediumFont(12.0f)


#pragma mark - 颜色

// 颜色
#define FJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 颜色+透明度
#define FJAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define FJRandomColor FJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/** 全局灰色色字体颜色 + placeHolder字体颜色*/
#define FJGlobalGrayTextColor       [UIColor colorWithHexString:@"#999999"]

/** 全局白色字体*/
#define FJGlobalWhiteTextColor      [UIColor colorWithHexString:@"#ffffff"]

/** 全局黑色字体*/
#define FJGlobalBlackTextColor      [UIColor colorWithHexString:@"#323232"]

/** 全局浅黑色字体*/
#define FJGlobalShadowBlackTextColor      [UIColor colorWithHexString:@"#646464"]

/** 全局灰色 背景*/
#define FJGlobalGrayBackgroundColor [UIColor colorWithHexString:@"#f8f8f8"]

/**全局细下滑线颜色 以及分割线颜色*/
#define FJGlobalBottomLineColor     [UIColor colorWithHexString:@"#d6d7dc"]

/**全局橙色*/
#define FJGlobalOrangeTextColor      [UIColor colorWithHexString:@"#394369"]
/**全局深蓝 */
#define FJGlobalDarkBlueTextColor      [UIColor colorWithHexString:@"#394369"]
/** 全局highLight 颜色 */
#define FJGlobalHighLightColor [UIColor colorWithWhite:0.000 alpha:0.220]

#pragma mark - 判断

// 是否为空对象
#define FJObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define FJStringIsEmpty(__string) ((__string.length == 0) || FJObjectIsNil(__string))

// 字符串不为空
#define FJStringIsNotEmpty(__string)  (!FJStringIsEmpty(__string))

// 数组为空
#define FJArrayIsEmpty(__array) ((FJObjectIsNil(__array)) || (__array.count==0))


#pragma mark - 图片

// 设置图片
#define FJImageNamed(__imageName) [UIImage imageNamed:__imageName]
#define FJGlobalUserDefaultAvatar [UIImage imageNamed:@"defaultAvatar"]

#endif /* Macro_h */

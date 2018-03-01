//
//  FJProgressHUDConfig.h
//  FJProgressHUDDemo
//
//  Created by MacBook on 2018/2/5.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#ifndef FJProgressHUDConfig_h
#define FJProgressHUDConfig_h

#define FJMainScreenBounds  [UIScreen mainScreen].bounds
#define FJMainScreenHeight  [UIScreen mainScreen].bounds.size.height
#define FJMainScreenWidth   [UIScreen mainScreen].bounds.size.width

#define FJFont(__size__) [UIFont systemFontOfSize:__size__]
#define FJGlobalTextFont FJFont(16)
//水平间隙
#define FJHorizontalSpace 20
//垂直间隙
#define FJVerticalSpace 10
//默认HUDView宽（不限高）
#define FJContentNormalWidth 180
//最大HUDView宽（不限高）
#define FJContentMaxWidth FJMainScreenWidth-FJHorizontalSpace*2
//HUD宽高
#define FJHUDWH 60
//动画时间
#define FJAnimationTime 0.3
//动态图展示时间
#define FJimageAnimationTime 3
//圆环宽度
#define FJStrokeWidth 3

// 颜色
#define FJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 颜色+透明度
#define FJAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//白色
#define FJGlobalTextColor FJColor(255,255,255)


#endif /* FJProgressHUDConfig_h */


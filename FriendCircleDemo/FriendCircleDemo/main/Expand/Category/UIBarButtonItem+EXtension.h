//
//  UIBarButtonItem+EXtension.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/27.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (EXtension)
/**
 *  返回没有调整图片
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;

/**
 *  没有文字调整的按钮
 */
+ (UIBarButtonItem *)itemWithName:(NSString *)Name fontSize:(CGFloat)fontSize color:(UIColor *)color target:target action:(SEL)action;

/**
 *  返回调整文字
 */
+ (NSArray *)itemsWithName:(NSString *)Name fontSize:(CGFloat)fontSize target:target action:(SEL)action;

/**
 *  返回调整图片
 */
+ (NSArray *)itemsWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;
/**
 *  用于调整frame
 */
+ (UIBarButtonItem *)itemWithFrame:(CGRect)frame ImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;
@end

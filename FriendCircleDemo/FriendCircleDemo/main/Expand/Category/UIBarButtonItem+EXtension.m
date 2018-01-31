//
//  UIBarButtonItem+EXtension.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/27.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "UIBarButtonItem+EXtension.h"

@implementation UIBarButtonItem (EXtension)
/**
 *  没有图片调整的按钮
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName != nil) {
        [button setImage: [UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = CGSizeMake(20, 20);
    button.adjustsImageWhenHighlighted = NO;
    //监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
//用于调整frame
+ (UIBarButtonItem *)itemWithFrame:(CGRect)frame ImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    //    button.backgroundColor = [UIColor redColor];
    // 设置按钮的背景图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName != nil) {
        [button setImage: [UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    // 设置按钮的尺寸为背景图片的尺寸
    button.frame = frame;
    button.adjustsImageWhenHighlighted = NO;
    //监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


/**
 *  没有文字调整的按钮
 */
+ (UIBarButtonItem *)itemWithName:(NSString *)Name fontSize:(CGFloat)fontSize color:(UIColor *)color target:target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont fj_fontForPingFangSC_RegularFontOfSize:fontSize];
    [btn setTitle:Name forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn sizeToFit];
    //监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

//有调整的文字按钮
+ (NSArray *)itemsWithName:(NSString *)Name fontSize:(CGFloat)fontSize target:target action:(SEL)action {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont fj_fontForPingFangSC_RegularFontOfSize:fontSize];
    [btn setTitle:Name forState:UIControlStateNormal];
    [btn sizeToFit];
    //监听按钮的点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return @[negativeSpacer, item];
}
//有调整的图片按钮
+ (NSArray *)itemsWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:imageName highImageName:highImageName target:target action:action];
    return @[negativeSpacer, item];
}
@end

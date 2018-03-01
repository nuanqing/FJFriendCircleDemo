//
//  FJProgressHUDInfo.h
//  FJProgressHUDDemo
//
//  Created by MacBook on 2018/2/6.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FJProgressHUDInfoModeType) {
    FJProgressHUDInfoHUD = 0,//HUD
    FJProgressHUDInfoCustom = 1//自定义
};

@interface FJProgressHUDInfo : NSObject

@property (nonatomic,assign) CGRect imageViewFrame;

@property (nonatomic,assign) CGRect contentViewFrame;

@property (nonatomic,assign) CGRect HUDFrame;

@property (nonatomic,assign) CGRect textLabelFrame;

@property (nonatomic,assign) CGSize textSize;

@property (nonatomic,assign) FJProgressHUDInfoModeType infoModeType;

- (void)layoutHUDWithText:(NSString *)text;

- (void)layoutOnlyHUD;

- (void)layoutOnlyCustom;

- (void)layoutCustomWithText:(NSString *)text;

- (void)layoutOnlyTextWithText:(NSString *)text;

- (void)layoutCustomWithText:(NSString *)text Width:(CGFloat)width height:(CGFloat)height;

- (void)drawLoadingCircle:(CALayer *)HUDLayer;

- (void)drawStatusSuccess:(CALayer *)HUDLayer;

- (void)drawStatusFail:(CALayer *)HUDLayer;

- (void)drawProgressCircle:(CALayer *)HUDLayer progress:(CGFloat)progress;

@end


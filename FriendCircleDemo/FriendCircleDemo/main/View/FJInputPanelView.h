//
//  FJInputPanelView.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/27.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJInputPanelView;
@protocol FJInputPanelViewDelegate<NSObject>

- (void)inputPanelViewKeyBoardShow:(FJInputPanelView *)inputPanelView;

- (void)textViewSendClicked;

@end

@interface FJInputPanelView : UIView

+ (instancetype)inputPanelView;

@property (nonatomic,strong) YYTextView *textView;

@property (nonatomic,assign) CGFloat recordHeight;

@property (nonatomic,weak) id<FJInputPanelViewDelegate> delegate;

@end

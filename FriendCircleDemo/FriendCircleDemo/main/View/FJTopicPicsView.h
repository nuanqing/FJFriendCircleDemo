//
//  FJTopicPicsView.h
//  FriendCircleDemo
//
//  Created by MacBook on 2018/2/1.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJTopicPicsView : UIView

@property (nonatomic,strong) NSMutableArray *imageViewArray;

@property (nonatomic,strong) NSMutableArray *picArray;

- (void)imageViewForPicArray:(NSMutableArray *)picArray;

@end

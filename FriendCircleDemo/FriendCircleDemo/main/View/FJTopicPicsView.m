//
//  FJTopicPicsView.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/2/1.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJTopicPicsView.h"
#import "SDPhotoBrowser.h"

@interface FJTopicPicsView()<SDPhotoBrowserDelegate>

@end

@implementation FJTopicPicsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapImageView:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = i;
        [self.imageViewArray addObject:imageView];
    }
    
}



- (void)imageViewForPicArray:(NSMutableArray *)picArray{
    //每次拿到数组隐藏所有的imageView，重新布局
    self.picArray = [picArray copy];
    
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.hidden = YES;
    }];
    //图片内容
    if (picArray.count > 0) {
        
        long perRowItemCount = [self _perRowItemCountForPicArry:picArray];
        CGFloat margin = FJTopicHorizontalSpace/2;
        CGFloat PicWH = [self _picWHForPicArray:picArray];
        
        [picArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIImageView *imageView = [self.imageViewArray objectAtIndex:idx];
            [imageView setImageWithURL:[NSURL URLWithString:picArray[idx]] placeholder:nil];
            
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;

             imageView.frame = CGRectMake(columnIndex * (PicWH + margin), rowIndex * (PicWH + margin), PicWH, PicWH);
            
            imageView.hidden = NO;
        }];
    }
}

- (void)_tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picArray.count;
    browser.delegate = self;
    [browser show];
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *picString = self.picArray[index];
    NSURL *url = [NSURL URLWithString:picString];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}


- (NSInteger)_perRowItemCountForPicArry:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)_picWHForPicArray:(NSArray *)array{
    if (array.count == 1) {
        return FJTopicOnePicWH;
    }
    return FJTopicMorePicWH;
}



- (NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [[NSMutableArray alloc]init];
    }
    return _imageViewArray;
}
@end

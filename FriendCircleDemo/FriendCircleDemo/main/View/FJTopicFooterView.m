//
//  FJTopicFooterView.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/23.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJTopicFooterView.h"

@interface FJTopicFooterView()

@property (nonatomic,strong) UILabel *line;

@end

@implementation FJTopicFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"topicFooter";
    FJTopicFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:indentifier];
    if (!footer) {
        footer = [[self alloc]initWithReuseIdentifier:indentifier];
    }
    return footer;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
       
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    self.line = [[UILabel alloc]init];
    self.line.frame = CGRectMake(0, FJTopicVerticalSpace-FJGlobalLineHeight, FJMainScreenWidth, FJGlobalLineHeight);
    self.line.backgroundColor = FJGlobalBottomLineColor;
    [self.contentView addSubview:_line];
    
}

- (void)setSection:(NSInteger)section allSections:(NSInteger)sections{
    if (sections == 1) {
        self.line.hidden = YES;
    }else if (section == sections - 1){
        self.line.hidden = YES;
    }else{
        self.line.hidden = NO;
    }
}


@end

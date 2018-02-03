//
//  FJTopicViewController.m
//  FriendCircleDemo
//
//  Created by MacBook on 2018/1/22.
//  Copyright © 2018年 nuanqing. All rights reserved.
//

#import "FJTopicViewController.h"
#import "FJTopicFrame.h"
#import "FJTopicHeaderView.h"
#import "FJTopicFooterView.h"
#import "FJCommentCell.h"
#import "FJUser.h"
#import "FJTopic.h"
#import "FJCommentFrame.h"
#import "FJInputPanelView.h"
#import "FJCommentReplyManager.h"

@interface FJTopicViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,FJTopicHeaderViewDelegate,FJCommentCellDelegate,FJInputPanelViewDelegate>

//话题数组
@property (nonatomic,strong) NSMutableArray *topicArray;
//话题frame数组
@property (nonatomic,strong) NSMutableArray *topicFrameArray;
//
@property (nonatomic,strong) NSMutableArray *userArray;

@property (nonatomic,copy) NSString *contentString;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) FJInputPanelView *inputPanelView;

@property (nonatomic,assign) CGFloat mainViewY;

@property (nonatomic,assign) CGFloat tableViewY;

@property (nonatomic,strong) NSString *lastSelectCell;

@property (nonatomic,strong) NSString *firstSelectCell;

@property (nonatomic,strong) FJCommentReplyManager *commentReplyManager;

@property (nonatomic,copy) NSString *recordCommentId;

@property (nonatomic,copy) NSString *recordTopicId;

@property (nonatomic,assign) NSInteger recordSection;

@property (nonatomic,assign) NSInteger recordRow;

@property (nonatomic,strong) FJUser *toUser;

@property (nonatomic,strong) NSMutableArray *picArray;

//是评论还是回复
@property (nonatomic,assign,getter=isReply) BOOL reply;

@end

@implementation FJTopicViewController{
    NSString *_lastCommentId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
    [self setupSubViewsConstraints];
}

- (void)setupUI{
    self.navigationItem.title = @"FriendCircle";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithName:@"发表" fontSize:FJUIBarButtonItemFontSize color:FJGlobalWhiteTextColor target:self action:@selector(rightBarButtonItemClicked)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputPanelView];
}

- (void)setupSubViewsConstraints{
    [self.inputPanelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(FJCommentInputHeight);
        make.left.equalTo(self.view);
        make.height.equalTo(@(FJCommentInputHeight));
        make.width.equalTo(self.view.mas_width);
    }];
}

- (void)setupData{
    NSDate *date = [NSDate date];
    for (int i = 0; i<5; i++) {
        // 话题
        FJTopic *topic = [[FJTopic alloc] init];
        FJTopicFrame *topicFrame = [[FJTopicFrame alloc] init];
        topic.topicId = [NSString stringWithFormat:@"100%zd",i];
        topic.thumbNums = [NSObject fj_randomNumber:1000 to:100000];
        topic.thumb = NO;
        NSTimeInterval t = date.timeIntervalSince1970 - 1000 *(30-i) - 60;
        topic.creatTime = [NSString stringWithTimeInterval:t];
        topic.text = [self.contentString substringFromIndex:[NSObject fj_randomNumber:0 to:self.contentString.length-1]];
        //随机加入图片
        for (int i = 0; i<[NSObject fj_randomNumber:0 to:self.picArray.count]; i++) {
            [topic.picArray addObject:self.picArray[i]];
        }
        //随机加入评论
        for (int i = 0; i<[NSObject fj_randomNumber:0 to:self.userArray.count]; i++) {
            [topic.likesArray addObject:self.userArray[i]];
        }
        
        topic.user = self.userArray[[NSObject fj_randomNumber:0 to:self.userArray.count-1]];
        
        
        //评论
        NSInteger commentsCount = [NSObject fj_randomNumber:0 to:9];
        for (int j=0; j<commentsCount; j++) {
            FJComment *comment = [[FJComment alloc]init];
            FJCommentFrame *commentFrame = [[FJCommentFrame alloc]init];
            comment.text = [self.contentString substringToIndex:[NSObject fj_randomNumber:0 to:100]];
            comment.commentId = [NSString stringWithFormat:@"110%d",i+j];
            _lastCommentId = comment.commentId;
            if (j%2 == 0) {
                comment.toUser = self.userArray[[NSObject fj_randomNumber:0 to:5]];
            }
             comment.fromUser = self.userArray[[NSObject fj_randomNumber:0 to:5]];
            [topic.commentArray addObject:comment];

            commentFrame.comment = comment;
            [topicFrame.commentFrameArray addObject:commentFrame];
        }
        topicFrame.topic = topic;
        [self.topicArray addObject:topic];
        [self.topicFrameArray addObject:topicFrame];
        
    }
    
}

- (void)rightBarButtonItemClicked{
    NSLog(@"发表说说!!!!!!!!");
    //演示
    NSDate *date = [NSDate date];
    NSTimeInterval t = date.timeIntervalSince1970;
    FJTopic *topic = [[FJTopic alloc] init];
    topic.topicId = [NSString stringWithFormat:@"100%zd",self.topicArray.count];
    topic.thumbNums = [NSObject fj_randomNumber:1000 to:100000];
    topic.thumb = NO;
    topic.creatTime = [NSString stringWithTimeInterval:t];
    topic.text = [self.contentString substringFromIndex:[NSObject fj_randomNumber:0 to:self.contentString.length-1]];
    topic.user = [FJUserManager sharedManager].user;
    
    FJTopicFrame *topicFrame = [[FJTopicFrame alloc] init];
    topicFrame.topic = topic;
    [self.topicArray insertObject:topic atIndex:0];
    [self.topicFrameArray insertObject:topicFrame atIndex:0];
    
    [self.tableView reloadData];
}

#pragma mark - FJInputPanelViewDelegate

- (void)inputPanelViewKeyBoardShow:(FJInputPanelView *)inputPanelView{
    if (self.tableViewY<inputPanelView.top) return;
    CGFloat distance = self.mainViewY - inputPanelView.top;
    CGFloat contentOffsetY = self.tableView.contentOffset.y + distance;
    [self.tableView setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
    
}

- (void)textViewSendClicked{
    
    [self.topicArray enumerateObjectsUsingBlock:^(FJTopic *topic, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == self.recordSection) {
            FJComment *comment = [[FJComment alloc]init];
            FJCommentFrame *commentFrame = [[FJCommentFrame alloc]init];
            comment.text = self.inputPanelView.textView.text;
            _lastCommentId = [NSString stringWithFormat:@"%ld",[_lastCommentId integerValue] + 1];
            comment.commentId = _lastCommentId;
            comment.fromUser = [FJUserManager sharedManager].user;
            if (self.isReply) {
                //回复
            comment.toUser = self.toUser;
            }
            commentFrame.comment = comment;
            [topic.commentArray insertObject:comment atIndex:self.recordRow];
            
            [self.topicFrameArray enumerateObjectsUsingBlock:^(FJTopicFrame *topicFrame, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == self.recordSection) {
                    [topicFrame.commentFrameArray addObject:commentFrame];
                }
                
            }];
        }
    }];
    [self.tableView beginUpdates];
    [self.tableView insertRow:self.recordRow inSection:self.recordSection withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    if (self.isReply) {
        [[FJCommentReplyManager manager] removeid:self.recordCommentId];
    }else{
        [[FJCommentReplyManager manager] removeid:self.recordTopicId];
    }
}

#pragma mark - TopicHeaderViewDelegate

/**
 点击头像
 */
- (void)topicHeaderViewAvatarDidClicked:(FJTopicHeaderView *)topicHeaderView{
    NSLog(@"%@",topicHeaderView.topic.user.avatarUrl);
}
/**
 点击更多
 */
- (void)topicHeaderViewMoreClicked:(FJTopicHeaderView *)topicHeaderView{
    
}
/**
 点击喜欢
 */
- (void)topicHeaderViewThumbClicked:(FJTopicHeaderView *)topicHeaderView{
    FJTopic *topic = topicHeaderView.topic;
    topic.thumb = !topic.isThumb;
    if (topic.isThumb) {
        topic.thumbNums+=1;
        [self.topicArray enumerateObjectsUsingBlock:^(FJTopic *topic, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == [self.topicArray indexOfObject:topicHeaderView.topic]) {
                [topic.likesArray addObject:[FJUserManager sharedManager].user];
                [self.topicFrameArray enumerateObjectsUsingBlock:^(FJTopicFrame *topicFrame, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == [self.topicArray indexOfObject:topicHeaderView.topic]) {
                        [topicFrame setTopic:topic];
                    }
                    
                }];
            }
            
        }];
        
    }else{
        topic.thumbNums-=1;
        [self.topicArray enumerateObjectsUsingBlock:^(FJTopic *topic, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == [self.topicArray indexOfObject:topicHeaderView.topic]) {
                [topic.likesArray removeObject:[FJUserManager sharedManager].user];
                [self.topicFrameArray enumerateObjectsUsingBlock:^(FJTopicFrame *topicFrame, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == [self.topicArray indexOfObject:topicHeaderView.topic]) {
                        [topicFrame setTopic:topic];
                    }
                    
                }];
            }
            
        }];
    }
    // 刷新数据
    [self.tableView reloadData];
}
/**
 点击昵称
 */
- (void)topicHeaderViewNickNameDidClicked:(FJUser *)user{
    NSLog(@"%@",user.nickname);
    
}
/**
 点击评论按钮
 */
- (void)topicHeaderViewCommentClicked:(FJTopicHeaderView *)topicHeaderView{
    if (!self.inputPanelView.textView.isFirstResponder) {
        self.tableViewY = 0.f;
        self.mainViewY = 0.f;
        [self.inputPanelView.textView becomeFirstResponder];
        //读取缓存
        [self getCommentWithId:topicHeaderView.topic.topicId nickname:NULL];
    }else{
        [self saveComment];
        [self.inputPanelView.textView resignFirstResponder];
        
        
    }
    self.recordTopicId = topicHeaderView.topic.topicId;
    //
    self.recordSection = [self.topicArray indexOfObject:topicHeaderView.topic];
    self.recordRow = topicHeaderView.topic.commentArray.count;
    self.reply = NO;
}
/**
 点击内容
 */
- (void)topicHeaderViewContentClicked:(FJTopicHeaderView *)topicHeaderView{
   
    if ([self.inputPanelView.textView isFirstResponder]) {
        [self saveComment];
        [self.inputPanelView.textView resignFirstResponder];
    }else{
         NSLog(@"查看详情!!!!!!!!");
    }
}
/**
 手机号链接点击
 */
- (void)topicHeaderViewMobileOrWebClicked:(NSString *)text{
    NSLog(@"%@",text);
}
/**
 评论用户点击
 */
- (void)commentCellUserClicked:(FJUser *)user{
    NSLog(@"%@",user.nickname);
    
}
/**
 评论手机号链接点击
 */
- (void)commentCellMobileOrWebClicked:(NSString *)text{
    NSLog(@"%@",text);
}


- (void)saveComment{
    
    if (!self.isReply) {
        //存评论
        [self.commentReplyManager setCommentReplyText:self.inputPanelView.textView.text topicId:self.recordTopicId];
    }else{
        //存回复
        [self.commentReplyManager setCommentText:self.inputPanelView.textView.text commentId:self.recordCommentId];
    }
}
    
- (void)getCommentWithId:(NSString *)inputId nickname:(NSString *)nickname{
    //读取缓存
    NSString *text = [self.commentReplyManager textWithCommentId:inputId];
    if (FJStringIsNotEmpty(text)) {
        self.inputPanelView.textView.text = text;
        [self.inputPanelView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.inputPanelView.recordHeight));
        }];
    }else{
        if (FJStringIsEmpty(nickname)) {
            self.inputPanelView.textView.placeholderText = @"评论";
        }else{
            self.inputPanelView.textView.placeholderText = [NSString stringWithFormat:@"回复:%@",nickname];
        }
        
        [self.inputPanelView mas_updateConstraints:^(MASConstraintMaker *make) {
             make.height.equalTo(@(FJCommentInputHeight));
        }];
        
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self saveComment];
    [self.inputPanelView.textView resignFirstResponder];
    
}



#pragma mark - UITableViewDelegate&&DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FJTopic *topic = self.topicArray[indexPath.section];
    topic.comment = topic.commentArray[indexPath.row];
    
    if ([topic.comment.fromUser.userId isEqualToString:[FJUserManager sharedManager].userId]) {
        NSLog(@"删除自己的评论!!!!!!!");
        return;
    }

    //找到点击cell的位置
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    self.mainViewY = CGRectGetMaxY(rect);
    self.tableViewY = CGRectGetMaxY(rectInTableView)+FJNavHeight;
    
    if (self.inputPanelView.textView.isFirstResponder) {
        [self saveComment];
        [self.inputPanelView.textView resignFirstResponder];
    }else{
        //先读取数据，布局
        [self getCommentWithId:topic.comment.commentId nickname:topic.comment.fromUser.nickname];
        //然后给个延迟弹键盘，否则主线程弹键盘与布局同时进行界面卡顿
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.inputPanelView.textView becomeFirstResponder];
        });
        
        
        
    }
    
    self.recordCommentId = topic.comment.commentId;
    self.recordSection = indexPath.section;
    self.recordRow = topic.commentArray.count;
    self.toUser = topic.comment.fromUser;
    self.reply = YES;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.topicArray.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FJTopic *topic = self.topicArray[section];
    return topic.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FJTopicFrame *topicFrame = self.topicFrameArray[indexPath.section];
    NSLog(@"%ld------%ld",indexPath.row,topicFrame.commentFrameArray.count);
    topicFrame.commentFrame = topicFrame.commentFrameArray[indexPath.row];
    return topicFrame.commentFrame.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    FJTopicFrame *topicFrame = self.topicFrameArray[section];
    return topicFrame.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return FJTopicVerticalSpace;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FJCommentCell *cell = [FJCommentCell cellWithTableView:tableView];
    
    FJTopicFrame *topicFrame = self.topicFrameArray[indexPath.section];
    topicFrame.commentFrame = topicFrame.commentFrameArray[indexPath.row];
    
    FJTopic *topic = self.topicArray[indexPath.section];
    topic.comment = topic.commentArray[indexPath.row];
    
    cell.commentFrame = topicFrame.commentFrame;
    cell.comment = topic.comment;
    
    cell.delegate = self;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FJTopicHeaderView *headerView = [FJTopicHeaderView headerViewWithTableView:tableView];
    
    FJTopicFrame *topicFrame = self.topicFrameArray[section];
    FJTopic *topic = self.topicArray[section];
    
    headerView.topicFrame = topicFrame;
    headerView.topic = topic;
    
    headerView.delegate = self;
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FJTopicFooterView *footerView = [FJTopicFooterView footerViewWithTableView:tableView];
    [footerView setSection:section allSections:self.topicArray.count];
    return footerView;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //点击空白区域收键盘
    if ([[touches anyObject].view isKindOfClass:[UITableView class]]||[[touches anyObject].view.superview isKindOfClass:[UITableViewHeaderFooterView class]]) {
        if ([self.inputPanelView.textView isFirstResponder]) {
            [self saveComment];
            [self.inputPanelView.textView resignFirstResponder];
        }
    }
}


#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (FJInputPanelView *)inputPanelView{
    if (!_inputPanelView) {
        _inputPanelView = [FJInputPanelView inputPanelView];
        _inputPanelView.backgroundColor =FJGlobalGrayBackgroundColor;
        _inputPanelView.delegate = self;
        [self.view addSubview:_inputPanelView];
    }
    return _inputPanelView;
}

- (FJCommentReplyManager *)commentReplyManager{
    if (!_commentReplyManager) {
        _commentReplyManager = [FJCommentReplyManager manager];
    }
    return _commentReplyManager;
}


- (NSMutableArray *)picArray{
    if (!_picArray) {
        _picArray = [[NSMutableArray alloc]init];
        for (int i = 1; i<10; i++) {
            NSString *picString = [NSString stringWithFormat:@"http://img.ivsky.com/img/tupian/t/201611/11/guaiwu_daxue_donghua-00%d.jpg",i];
            [_picArray addObject:picString];
        }
    }
    return _picArray;
}

- (NSMutableArray *)userArray{
    if (!_userArray) {
        _userArray = [[NSMutableArray alloc]init];
        FJUser *user0 = [[FJUser alloc] init];
        user0.userId = @"1000";
        user0.nickname = @"冯宝宝";
        user0.avatarUrl = @"http://img2.woyaogexing.com/2017/07/30/f195c510519a7761!388x388_big.png";
        [_userArray addObject:user0];
        
        
        FJUser *user1 = [[FJUser alloc] init];
        user1.userId = @"1001";
        user1.nickname = @"路飞";
        user1.avatarUrl = @"http://img2.woyaogexing.com/2017/07/17/d9c5eb7ce1454bb8!400x400_big.jpg";
        [_userArray addObject:user1];
        
        
        FJUser *user2 = [[FJUser alloc] init];
        user2.userId = @"1002";
        user2.nickname = @"鸣人";
        user2.avatarUrl = @"http://img2.woyaogexing.com/2017/07/10/42b2eea30ed7fd92!400x400_big.jpg";
        [_userArray addObject:user2];
        
        
        FJUser *user3 = [[FJUser alloc] init];
        user3.userId = @"1003";
        user3.nickname = @"佐助";
        user3.avatarUrl = @"http://img2.woyaogexing.com/2017/07/04/7b2dab5c6030f40d!400x400_big.jpg";
        [_userArray addObject:user3];
        
        
        FJUser *user4 = [[FJUser alloc] init];
        user4.userId = @"1004";
        user4.nickname = @"派大星";
        user4.avatarUrl = @"http://img2.woyaogexing.com/2017/07/03/31d9ef8f6948129f!400x400_big.jpg";
        [_userArray addObject:user4];
        
        
        FJUser *user5 = [[FJUser alloc] init];
        user5.userId = @"1005";
        user5.nickname = @"小鹿";
        user5.avatarUrl = @"http://img2.woyaogexing.com/2017/06/12/b035bc4405192cc5!400x400_big.jpg";
        [_userArray addObject:user5];
        
        
        FJUser *user6 = [[FJUser alloc] init];
        user6.userId = @"1006";
        user6.nickname = @"叶修";
        user6.avatarUrl = @"http://img2.woyaogexing.com/2017/06/08/3a00b4d71dd49548!400x400_big.jpg";
        [_userArray addObject:user6];
        
        
        FJUser *user7 = [[FJUser alloc] init];
        user7.userId = @"1007";
        user7.nickname = @"亚索";
        user7.avatarUrl = @"http://img2.woyaogexing.com/2017/06/05/62399f3f2915913e!400x400_big.jpg";
        [_userArray addObject:user7];
        
        
        FJUser *user8 = [[FJUser alloc] init];
        user8.userId = @"1008";
        user8.nickname = @"锤石";
        user8.avatarUrl = @"http://img2.woyaogexing.com/2017/05/24/71620c0119e230e9!400x400_big.jpg";
        [_userArray addObject:user8];
        
    }
    return _userArray;
}

- (NSMutableArray *)topicArray{
    if (!_topicArray) {
        _topicArray = [[NSMutableArray alloc]init];
    }
    return _topicArray;
}

- (NSMutableArray *)topicFrameArray{
    if (!_topicFrameArray) {
        _topicFrameArray = [[NSMutableArray alloc]init];
    }
    return _topicFrameArray;
}

- (NSString *)contentString{
    if (!_contentString) {
        _contentString = @"尤利西斯，http://www.baidu.com尤利西斯-在所有星系中翱翔。在寻找地球，飞到夜晚。尤利西斯，尤利西斯-对抗邪恶和暴政，用他所有的力量，和他所有的力量。尤利西斯-没有人能做你所做的事。13348633342,尤利西斯-就像晴天霹雳。尤利西斯-总是与所有邪恶势力战斗，为所有人带来和平与正义。\n《霹雳游侠》(Knight Rider)，这是一个幽灵般的飞行,18317824699进入一个不存在的人的危险世界。迈克尔·奈特(Michael Knight)是一位年轻的孤独者，www.baidu.com他发起了一场十字军运动，以捍卫无辜的事业https://www.baidu.com";
    }
    return _contentString;
}


- (void)dealloc{
    FJDealloc;
}

@end

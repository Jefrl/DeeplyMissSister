//
//  HXLPersonDetailViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/19.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPersonDetailViewController.h"
#import "HXLFollowUserItem.h"
#import "UIImageView+HXLSDWeb.h"

@interface HXLPersonDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLayoutHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLayoutTopTosuper;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picLayoutHeight;
@property (weak, nonatomic) IBOutlet UIImageView *useIcon;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
/** underline 下划线保存 */
@property (nonatomic, weak) UIView *underline;
/** lastBtn 上一次选中的按钮 */
@property (nonatomic, readwrite, strong) UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIButton *topicBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation HXLPersonDetailViewController
#pragma mark - 托线区域
// 关注
- (IBAction)followingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

// 帖子按钮点击
- (IBAction)topic:(UIButton *)sender {
    [self moveUnderlineBtn:sender];
}

// 分享按钮点击
- (IBAction)share:(UIButton *)sender {
    [self moveUnderlineBtn:sender];
    
}

// 评论按钮点击
- (IBAction)comment:(UIButton *)sender {
    [self moveUnderlineBtn:sender];
    
}

#pragma mark - 抽取方法 from 拖线区域 >
- (void)moveUnderlineBtn: (UIButton *)sender
{
    if (sender.isSelected) {
        return;
    }
    // 计算对应按钮中文字的长度
    CGFloat width = [sender.titleLabel.text boundingRectWithSize:SCREEN.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_15} context:nil].size.width;
    
    _underline.size = CGSizeMake(width, Underline_height);
    _underline.y = _topicBtn.height - Underline_height;
    
    // 下划线动画
    [UIView animateWithDuration:0.5 animations:^{
        _underline.centerX = sender.centerX;
    } completion:nil];
    
    // 选中当前按钮, 恢复上一个, 并记录当前为上一个
    sender.selected = YES;
    _lastBtn.selected = NO;
    _lastBtn = sender;
}

#pragma mark - 初始化区域
- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一界面基本风格
    [self setupUniformStyle];

    // 下划线的创建
    [self setupUnderLine];

    // 网络刷新控件初始化
    [self setupRefresh];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@\n%@", NSStringFromCGRect(self.tableView.frame), NSStringFromUIEdgeInsets(self.tableView.contentInset));
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 离开时恢复原状态;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundN"] forBarMetrics:UIBarMetricsDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 抽取的方法 from 初始化区域
- (void)setupUnderLine
{
    // 下划线的创建
    UIView *underline = [[UIView alloc] init];
    _underline = underline;
    _underline.backgroundColor = RED_COLOR;
    [self.topicBtn addSubview:_underline];
    // 默认选中帖子 btn;
    [self topic:_topicBtn];
    _lastBtn = _topicBtn;
}

- (void)setupUniformStyle
{
    // 界面统一风格
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(scrollValue, 0, 0, 0);
    
    self.title = _userItem.screen_name;
    self.fansCount.text = [NSString stringWithFormat:@"%@ 粉丝", [NSString stringFansFollowWithString:_userItem.fans_count]];
    self.followingCount.text = [NSString stringWithFormat:@"0 关注"];
    if (_userItem.introduction.length) {
        self.introduction.hidden = NO;
        self.introduction.text = _userItem.introduction;
    }
    
    self.postCount.text = [NSString stringWithFormat:@"%ld个帖子", _userItem.tiezi_count];
    [self.useIcon setImageString:_userItem.header placeholderImage:[UIImage imageNamed:bigplaceholder] circleImage:YES];
    self.detailImageView.image = [UIImage imageNamed:@"godsplaycard"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 30;
    
    //  用颜色图片透明的方法来透明导航栏的背景图片
    //把一个颜色生成一张图片
    UIColor *color = RGBColor(255, 0, 0, 0);
    UIImage *narImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:narImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init] ];
}

#pragma mark - 网络数据加载区域
- (void)setupRefresh
{
    
}

#pragma mark - TableView Delegate or DataSource
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat offset = (scrollView.contentOffset.y);
//    //整体 View, 坐标实际变化值, 初始为0;
//    CGFloat constant = - offset - scrollValue ;
//    self.detailLayoutTopTosuper.constant = constant;
//    NSLog(@"scrollView.contentOffset.y== %.2f, offset== %.2f, constant== %.2f", scrollView.contentOffset.y, offset, constant);
//    self.detailLayoutHeight.constant = picH + constant;
////    self.detailLayoutHeight.constant = scrollValue + constant;
//    
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = (scrollView.contentOffset.y);
    //整体 View, 坐标实际变化值, 初始为0;
    CGFloat constant = - offset - scrollValue ;
    
    CGFloat alpha = 0.0;
    if (constant < 0) { // 显示出来, 代表tableView 的负滚动变小, 整体 View, 坐标变负数,
        alpha = 0.99;
        self.detailLayoutTopTosuper.constant = constant;
       // NSLog(@"offset== %.2f, constant== %.2f", offset, constant);
    } else if (constant >= 0) {
        alpha = 0;
        self.detailLayoutTopTosuper.constant = 0; // 切记不能少了顶部固定点, 搞得我要死没发现, 总是思维凝固,,~~~~(>_<)~~~~
        self.detailLayoutHeight.constant = scrollValue + constant;
    }
    
    //把一个颜色生成一张图片
    UIColor *color = RGBColor(255, 0, 0, alpha);
    UIImage *narImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:narImage forBarMetrics:UIBarMetricsDefault];
    
        NSLog(@"%@\n%@", NSStringFromCGRect(self.tableView.frame), NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//    self.tableView.y = 240 + 150;
//}

@end

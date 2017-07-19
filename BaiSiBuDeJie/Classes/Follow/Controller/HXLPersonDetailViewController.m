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
@property (weak, nonatomic) IBOutlet UIImageView *useIcon;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *introduction;

@end

@implementation HXLPersonDetailViewController
#pragma mark - 托线区域
// 关注
- (IBAction)followingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

// 帖子按钮点击
- (IBAction)topic:(UIButton *)sender {
    sender.selected = !sender.selected;
}

// 分享按钮点击
- (IBAction)share:(UIButton *)sender {
    sender.selected = !sender.selected;
}

// 评论按钮点击
- (IBAction)comment:(UIButton *)sender {
    sender.selected = !sender.selected;
}

static CGFloat scrollValue = 240+150;
#pragma mark - 初始化区域
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.tableView.backgroundColor = RED_COLOR;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@/n%@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.tableView.frame));
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 网络数据加载区域
- (void)setupRefresh
{
    
}

static CGFloat picH = 240;
#pragma mark - TableView Delegate or DataSource
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = - scrollValue - scrollView.contentOffset.y;

    CGFloat constant = picH + offset;
    self.detailLayoutHeight.constant = constant;
    NSLog(@"offset== %.2f", offset);
    NSLog(@"scrollView.contentOffset.y== %.2f, offset== %.2f, constant== %.2f", scrollView.contentOffset.y, offset, constant);
    
    CGFloat alpha = constant * 1 / picH;
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    if (alpha < 1) {
        alpha = 0;
    }
    //把一个颜色生成一张图片
    UIColor *color = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *narImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:narImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
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

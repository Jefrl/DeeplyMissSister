//
//  HXLMineViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineViewController.h"
#import "HXLSettingTableViewController.h"

#import "HXLMineTableViewCell.h"
#import "HXLMineFootView.h"

@interface HXLMineViewController ()

@end

@implementation HXLMineViewController

#pragma mark - Initial Setting
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUniformStyle];
}

/** 状态栏的设置 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/** UI 界面的统一风格 */
- (void)setupUniformStyle {
    // navBar 条上的控件设置
    [self setupNavigationBar];
    
    // 系统滚动设置self.automaticallyAdjustsScrollViewInsets = NO;
    // 由于自定义了滚动, tableView 的头部增加64, 每个 section 的底部调整10
    self.tableView.contentInset = UIEdgeInsetsMake( - mineSectionSroll + essenceMargin_y, 0, 937.50 - 2 * essenceMargin_y, 0);
    self.tableView.backgroundColor = GRAY_PUBLIC_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 组高设置(不然会有默认值)
    self.tableView.sectionFooterHeight = essenceMargin_y;
    self.tableView.sectionHeaderHeight = 0;
    
    // 注册 cell
    [self.tableView registerClass:[HXLMineTableViewCell class] forCellReuseIdentifier:mineCell];
    self.tableView.rowHeight = 50;
    
    /** 设置 tableView 的底部视图 */
    HXLMineFootView *footView = [[HXLMineFootView alloc] init];
    self.tableView.tableFooterView = footView;
}




#pragma mark - TableView Delegate or DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    [self contentInset];
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXLMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    
    cell.imageView.image = (0 == indexPath.section) ? [UIImage imageNamed:@"setup-head-default"] : nil;
    cell.textLabel.text = (indexPath.section == 0) ? @"登录/注册" : @"离线下载";
    
    return cell;
}

#pragma mark - 抽取的方法 from/ Initial Setting
/** 导航栏的搭建 */
- (void)setupNavigationBar {
    
    // 设置导航栏的 title
    self.navigationItem.title = @"我的";
    
    // 设置导航栏左&右 Item
    UIImage *imageNormal = [UIImage imageNamed:@"nav_coin_icon"];
    UIImage *imageHighlighted = [UIImage imageNamed:@"nav_coin_icon_click"];
    
    UIImage *R1_imageNormal = [UIImage imageNamed:@"mine-setting-icon"];
    UIImage *R1_imageHighlighted = [UIImage imageNamed:@"mine-setting-icon-click"];
    UIImage *R2_imageNormal = [UIImage imageNamed:@"mine-moon-icon"];
    UIImage *R2_imageHighlighted = [UIImage imageNamed:@"mine-moon-icon-click"];
    
    UIBarButtonItem *leftBarBtnItem = [UIBarButtonItem barButtonItemImage:imageNormal selectedImage:imageHighlighted addTarget:self action:@selector(leftBarBtnItemClick:) contentEdgeInsets:UIEdgeInsetsZero forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    
    UIBarButtonItem *right1_BarBtnItem = [UIBarButtonItem barButtonItemImage:R1_imageNormal selectedImage:R1_imageHighlighted addTarget:self action:@selector(right1_BarBtnItemClick:) contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5) forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    UIBarButtonItem *right2_BarBtnItem = [UIBarButtonItem barButtonItemImage:R2_imageNormal selectedImage:R2_imageHighlighted addTarget:self action:@selector(right2_BarBtnItemClick:) contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10) forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    self.navigationItem.rightBarButtonItems = @[right1_BarBtnItem, right2_BarBtnItem];
}

/** 导航栏左&右侧的点击事件 */
- (void)leftBarBtnItemClick:(UIButton *)btn {
    
    NSLog(@"左侧按钮被点击了");
}

- (void)right1_BarBtnItemClick:(UIButton *)btn {
    HXLSettingTableViewController *settingTVC = [[HXLSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingTVC animated:YES];
}

- (void)right2_BarBtnItemClick:(UIButton *)btn {
    
    if (btn.tag == 0) { // 本身是白天0, 则变成夜间模式1
        
        btn.tag = 1;
        [btn setImage:[UIImage imageNamed:@"mine-sun-icon"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"mine-sun-icon-click"] forState:UIControlStateHighlighted];
        
    } else { // 本身是夜间 1, 则变白天模式 0;
        
        btn.tag = 0;
        [btn setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    }
    
    NSLog(@"当前 btn.tag 的模式为: %lu (PS: 1-代表夜间模式, 0-代表白天模式)", btn.tag);
}




@end

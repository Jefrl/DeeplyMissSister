//
//  HXLFollowViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLFollowViewController.h"
#import "HXLLoginRegisterViewController.h"
#import "HXLFollowFriendTrendsVC.h"

@interface HXLFollowViewController ()

@end

@implementation HXLFollowViewController
- (IBAction)loginOrLogout:(UIButton *)sender {
    HXLLoginRegisterViewController *loginRegisterVC = [[HXLLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

/** 状态栏的设置 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/** UI 界面的搭建 */
- (void)setup {
    
    [self setupNavigationBar];
}

#pragma mark - 01
/** 导航栏的搭建 */
- (void)setupNavigationBar {
    
    // 设置导航栏的 title
    self.navigationItem.title = @"关注";
    
    // 设置导航栏左&右 Item
    UIImage *imageNormal = [UIImage imageNamed:@"cellFollowIcon"];
    UIImage *imageHighlighted = [UIImage imageNamed:@"cellFollowDisableIcon"];
    
    UIImage *R_imageNormal = [UIImage imageNamed:@"nav_search_icon"];
    UIImage *R_imageHighlighted = [UIImage imageNamed:@"nav_search_icon_click"];
    
    UIBarButtonItem *leftBarBtnItem = [UIBarButtonItem barButtonItemImage:imageNormal selectedImage:imageHighlighted addTarget:self action:@selector(leftBarBtnItemClick:) contentEdgeInsets:UIEdgeInsetsZero forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    UIBarButtonItem *rightBarBtnItem = [UIBarButtonItem barButtonItemImage:R_imageNormal selectedImage:R_imageHighlighted addTarget:self action:@selector(rightBarBtnItemClick:) contentEdgeInsets:UIEdgeInsetsZero forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

/** 导航栏左&右侧的点击事件 */
- (void)leftBarBtnItemClick:(UIButton *)btn {
    
    HXLFollowFriendTrendsVC *trendsVC = [[HXLFollowFriendTrendsVC alloc] init];
    [self.navigationController pushViewController:trendsVC animated:YES];
}

- (void)rightBarBtnItemClick:(UIButton *)btn {
    NSLog(@"右侧 Item 被点击了");
}


@end

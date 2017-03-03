//
//  HXLMineViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineViewController.h"

@interface HXLMineViewController ()

@end

@implementation HXLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBRandomColor;
    [self setup];
}

///** 状态栏的设置 */
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

/** UI 界面的搭建 */
- (void)setup {
    
    [self setupNavigationBar];
}

#pragma mark - 01
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
    
    UIBarButtonItem *leftBarBtnItem = [UIBarButtonItem barButtonItemImage:imageNormal selectedImage:imageHighlighted addTarget:self action:@selector(leftBarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right1_BarBtnItem = [UIBarButtonItem barButtonItemImage:R1_imageNormal selectedImage:R1_imageHighlighted addTarget:self action:@selector(right1_BarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right2_BarBtnItem = [UIBarButtonItem barButtonItemImage:R2_imageNormal selectedImage:R2_imageHighlighted addTarget:self action:@selector(right2_BarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    right2_BarBtnItem.customView
    
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    self.navigationItem.rightBarButtonItems = @[right1_BarBtnItem, right2_BarBtnItem];
}

/** 导航栏左&右侧的点击事件 */
- (void)leftBarBtnItemClick:(UIButton *)btn {
    
    NSLog(@"左侧按钮被点击了");
}

- (void)right1_BarBtnItemClick:(UIButton *)btn {
    NSLog(@"右侧第一个 Item 被点击了");
}

- (void)right2_BarBtnItemClick:(UIButton *)btn {
    
    if (btn.tag == 0) { // 本身是白天, 则变成夜间模式
        
        btn.tag = 1;
        [btn setImage:[UIImage imageNamed:@"mine-sun-icon"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"mine-sun-icon-click"] forState:UIControlStateHighlighted];
        
    } else { // 本身是夜间, 则变白天模式 mine-sun-icon-click
        
        btn.tag = 0;
        [btn setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
        
    }
    
    NSLog(@"右侧第二个 Item 被点击了, btn.tag == %lu (PS: 1-代表开启夜间模式, 0-代表关闭夜间模式)", btn.tag);
}

@end

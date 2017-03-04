//
//  HXLEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceViewController.h"


@interface HXLEssenceViewController ()

@end

@implementation HXLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBRandomColor;
    
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

#pragma mark - 02
#pragma mark - 01
/** 导航栏的搭建 */
- (void)setupNavigationBar {
    
    // 设置导航栏的 titleView
    UIImage *imageOrigin = [UIImage imageNamed:@"MainTitle"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:imageOrigin];
    [bgImageView sizeToFit];
    self.navigationItem.titleView = bgImageView;
    
    // 设置导航栏左&右 Item
    UIImage *imageNormal = [UIImage imageNamed:@"nav_item_game_icon"];
    UIImage *imageHighlighted = [UIImage imageNamed:@"nav_item_game_click_icon"];
    
    UIImage *R_imageNormal = [UIImage imageNamed:@"navigationButtonRandomN"];
    UIImage *R_imageHighlighted = [UIImage imageNamed:@"navigationButtonRandomClickN"];
    
    UIBarButtonItem *leftBarBtnItem = [UIBarButtonItem barButtonItemImage:imageNormal selectedImage:imageHighlighted addTarget:self action:@selector(leftBarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtnItem = [UIBarButtonItem barButtonItemImage:R_imageNormal selectedImage:R_imageHighlighted addTarget:self action:@selector(rightBarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

/** 导航栏左&右侧的点击事件 */
- (void)leftBarBtnItemClick:(UIButton *)btn {
    
    NSLog(@"左侧按钮被点击了");
}

- (void)rightBarBtnItemClick:(UIButton *)btn {
    NSLog(@"右侧 Item 被点击了");
}

@end
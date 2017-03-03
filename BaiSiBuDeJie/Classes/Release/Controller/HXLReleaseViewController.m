//
//  HXLReleaseViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLReleaseViewController.h"

@interface HXLReleaseViewController ()

@end

@implementation HXLReleaseViewController

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
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
}

- (void)backBtnClick:(UIButton *)btn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end

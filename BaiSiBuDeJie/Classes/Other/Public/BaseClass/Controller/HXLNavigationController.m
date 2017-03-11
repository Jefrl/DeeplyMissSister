//
//  HXLNavigationController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLNavigationController.h"

@interface HXLNavigationController ()

@end

@implementation HXLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleTextAttributesOfSize:FONT_17 foregroundColor:[UIColor whiteColor]];
}

/** 导航栏 title 字体风格设置 */
- (void)setTitleTextAttributesOfSize:(UIFont *)fontSize foregroundColor:(UIColor *)foregroundColor {
    
    NSMutableDictionary *dictM_titleText = [NSMutableDictionary dictionary];
    dictM_titleText[NSFontAttributeName] = FONT_17;
    dictM_titleText[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UINavigationBar *navgationBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [navgationBar setTitleTextAttributes:dictM_titleText];
    [navgationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundN"] forBarMetrics:UIBarMetricsDefault];
}

/** 设置栈顶控制器的状态栏 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end

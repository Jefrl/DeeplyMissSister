//
//  HXLTabBarController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLTabBarController.h"
#import "HXLEssenceViewController.h"
#import "HXLLastestViewController.h"
#import "HXLReleaseViewController.h"
#import "HXLFollowViewController.h"
#import "HXLMineViewController.h"

#import "HXLNavigationController.h"
#import "HXLTabBar.h"

@interface HXLTabBarController ()

@end

@implementation HXLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    
}

/** 搭建主界面 */
- (void)setup {
    // 设置 tabBar 字体统一风格
    [self setupTabBar];
    // 添加所有子控制器
    [self setupAllChildVC];
    // 处理 tabBar 条(只读属性, 用 kvc 来访问)
//    self.tabBar = [[UITabBar alloc] init];
    [self setValue:[[HXLTabBar alloc] init] forKey:@"tabBar"];

}

/** 设置 tabBar 字体统一风格 */
- (void)setupTabBar {
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    
    // 选中前&后 tabBarItem 的颜色
    [self SetTitleTextAttributesOfSize:FONT_11 titleTextColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self SetTitleTextAttributesOfSize:FONT_11 titleTextColor:[UIColor redColor] forState:UIControlStateSelected];
    
}

/** 选中前&后 tabBarItem 的文字设置 */
- (void)SetTitleTextAttributesOfSize:(UIFont *)fontSize titleTextColor:(UIColor *)titleTextColor forState:(UIControlState)controlState {
    
    NSMutableDictionary *dictM_titleText = [NSMutableDictionary dictionary];
    dictM_titleText[NSFontAttributeName] = fontSize;
    dictM_titleText[NSForegroundColorAttributeName] = titleTextColor;
    
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    [tabBarItem setTitleTextAttributes:dictM_titleText forState:controlState];
}

#pragma mark - 01

/** 添加所有子控制器 */
- (void)setupAllChildVC {
    // 精华 最新 关注 我的
    HXLEssenceViewController *essenceVC = [[HXLEssenceViewController alloc] init];
    HXLLastestViewController *lastestVC = [[HXLLastestViewController alloc] init];
    HXLFollowViewController *followVC = [[HXLFollowViewController alloc] init];
    
    HXLMineViewController *mineVC = [[HXLMineViewController alloc] init];
    
    [self addCustomChildViewController:essenceVC image:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_essence_icon"]] selectedImage:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_essence_click_icon"]] title:@"精华"];
    [self addCustomChildViewController:lastestVC image:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_new_icon"]] selectedImage:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_new_click_icon"]] title:@"最新"];
    
    [self addCustomChildViewController:followVC image:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_friendTrends_icon"]] selectedImage:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]] title:@"关注"];
    [self addCustomChildViewController:mineVC image:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_me_icon"]] selectedImage:[UIImage imageRenderingModeAlwaysOriginal:[UIImage imageNamed:@"tabBar_me_click_icon"]] title:@"我"];
}

/** 创建导航控制器, 并成为 UITabBarC 的子控制 */
- (void)addCustomChildViewController:(UIViewController *)childController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
    NSLog(@"%@--", NSStringFromCGRect(childController.view.frame));
    
    HXLNavigationController *childNavC = [[HXLNavigationController alloc] initWithRootViewController:childController];
    NSLog(@"%@", NSStringFromCGRect(childNavC.view.frame));
    
    // 将包装好的导航控制器添加到 tabBar 控制器中
    [self addChildViewController:childNavC];
    
    childNavC.tabBarItem.image = image;
    childNavC.tabBarItem.selectedImage = selectedImage;
    childNavC.tabBarItem.title = title;
}



/** tabBar 点击 */
/** 
 UIImage *imageStayOrigin = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 */


@end

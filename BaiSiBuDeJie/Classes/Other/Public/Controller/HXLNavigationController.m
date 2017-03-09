//
//  HXLNavigationController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLNavigationController.h"

@interface HXLNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation HXLNavigationController

/* 什么时候调用: 当程序已启动的时候就会调用
   作用: 把当前类加载进内存,放在代码区
+ (void)load{...}

 什么时候调用: 当 当前类/子类 第一次初始化当前类的时候调用
 作用: 初始化这个类
+ (void)initialize {...} */
/** 导航栏字体风格设置 */
+ (void)initialize {
    
    NSMutableDictionary *dictM_titleText = [NSMutableDictionary dictionary];
    dictM_titleText[NSFontAttributeName] = FONT_17;
    dictM_titleText[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    // 当导航栏用在XMGNavigationController中, appearance设置才会生效, 且appearance 获取整个工程下的导航条标识
    // 一般用 UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *navgationBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [navgationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    [navgationBar setTitleTextAttributes:dictM_titleText];
    
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // UIControlStateNormal
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = GRAY_COLOR;
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // UIControlStateHighlighted
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSForegroundColorAttributeName] = WHITE_COLOR;
    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateHighlighted];
    
    // 设置导航条上按钮位置
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 全屏侧滑
    // 2.自己写一个手势 全屏滑动移除控制器
    // action handleNavigationTransition:
    // traget: self.interactivePopGestureRecognizer.delegate
    
    // 禁用UINavigationController 的系统的pop 手势
    self.interactivePopGestureRecognizer.enabled = NO;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    
    panGes.delegate = self;
    [self.view addGestureRecognizer:panGes];
}

#pragma mark - UIGestureRecognizerDelegate
// 禁止根控制器时有手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 非根控制器时, 允许手势
    return self.viewControllers.count > 1;
}

/** 隐藏底部tabBar 条 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 非根控制器时, 隐藏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

/** 设置栈顶控制器的状态栏 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end

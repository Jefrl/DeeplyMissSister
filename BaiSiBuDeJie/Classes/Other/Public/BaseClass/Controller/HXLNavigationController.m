//
//  HXLNavigationController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLNavigationController.h"
#import "HXLPersonDetailViewController.h"

@interface HXLNavigationController () <UIGestureRecognizerDelegate>
/** backgroundImage */
@property (nonatomic, readwrite, strong) UIImage *backgroundImage;

@end

@implementation HXLNavigationController
#pragma mark - Initialization setting
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFullscreenBack];
    
    [self setTitleTextAttributesOfSize:FONT_17 foregroundColor:[UIColor whiteColor]];
}

/** 导航栏 title 字体风格设置 */
- (void)setTitleTextAttributesOfSize:(UIFont *)fontSize foregroundColor:(UIColor *)foregroundColor {
    
    NSMutableDictionary *dictM_titleText = [NSMutableDictionary dictionary];
    dictM_titleText[NSFontAttributeName] = FONT_17;
    dictM_titleText[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 老方法已废除
    UINavigationBar *navgationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:
    @[[self class]]];
    
    [navgationBar setTitleTextAttributes:dictM_titleText];
    // 背景色或图片
    self.backgroundImage = [UIImage imageNamed:@"navigationbarBackgroundN"];
    
    [navgationBar setBackgroundImage:_backgroundImage forBarMetrics:UIBarMetricsDefault];
}

/** 供系统的导航控制器调用, 来精准设置栈顶子控制器的状态栏 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

#pragma mark - Optimaize method zone
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isMemberOfClass:[HXLPersonDetailViewController class]]) {
        HXLPersonDetailViewController *vc = (HXLPersonDetailViewController *)viewController;
        vc.backgroundImage = _backgroundImage;
    }
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置push 进来的非根控制器的左侧返回 item 条
        UIImage *NormalImage = [UIImage imageNamed:@"navigationButtonReturn"];
        UIImage *selectedImage = [UIImage imageNamed:@"navigationButtonReturnClick"];
        
        UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemImage:NormalImage selectedImage:selectedImage title:@"返回" titltColor:GRAY_COLOR titleSelectedColor:WHITE_COLOR fontSize:FONT_15 addTarget:self action:@selector(backItemClick:) contentEdgeInsets:UIEdgeInsetsMake(0, -2 * essenceMargin_y, 0, 0) titleEdgeInsets:UIEdgeInsetsMake(0, DIY, 0, 0) forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];

        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)backItemClick:(UIBarButtonItem *)sender
{
    [self popViewControllerAnimated:YES];
}

- (void)setupFullscreenBack
{
    /*
    NSLog(@"%@", self.interactivePopGestureRecognizer);
    NSLog(@"%@", self.interactivePopGestureRecognizer.delegate);
 Log: <
        UIScreenEdgePanGestureRecognizer: 0x7febe4d17250; state = Possible;
        delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7febe4d12e30
      >;
      target= <
            (action=handleNavigationTransition:,
             target=<_UINavigationInteractiveTransition 0x7fd963c02b10)>
                 >
    
  Log: <_UINavigationInteractiveTransition: 0x7fd963c02b10> */ // 相同地址也就证实了, self.interactivePopGestureRecognizer.delegate =就是= target
    
    // 2.自己写一个手势 全屏滑动移除控制器
    // action: handleNavigationTransition:
    // traget: self.interactivePopGestureRecognizer.delegate
    // 禁用系统的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    id target = self.interactivePopGestureRecognizer.delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    [self.view addGestureRecognizer:pan];

    // 为了现实下面的手势允许判断;
    pan.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{ // 根控制器不允许出栈, 会卡死
    return self.viewControllers.count > 1;
}

@end

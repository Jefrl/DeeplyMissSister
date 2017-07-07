//
//  HXLTabBar.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/3.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLTabBar.h"
#import "HXLReleaseViewController.h"

@interface HXLTabBar ()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *releaseBtn;


@end

@implementation HXLTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建发布按钮
        UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [releaseBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [releaseBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [releaseBtn addTarget:self action:@selector(releaseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:releaseBtn];
        self.releaseBtn = releaseBtn;

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // tabBar 按钮的总个数
    NSInteger btnCount = 0;
    for (UIControl *controlBtn in self.subviews) {
        // 要同时包含 UIButton 跟 UITabBarButton 的类
        if ([controlBtn isKindOfClass:[UIControl class]]) {
            btnCount ++;
        }
    }
    
    // 子控件布局
    NSInteger releaseIndex = 2;
    NSInteger num = 0;
    CGFloat itemY = 0.0;
    CGFloat itemW = SCREEN_WIDTH / btnCount;
    CGFloat itemH = TABBAR_HEIGHT;
    self.releaseBtn.frame = CGRectMake(itemW * releaseIndex, itemY, itemW, itemH);
    
    for (UIControl *tabBarButton in self.subviews) {
        // 过虑掉已经设置好 frame 的发布按钮
        if (![tabBarButton isMemberOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 注册一个发通知的
        [tabBarButton addTarget:self action:@selector(postNotiClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat tempNum = num > 1 ? num+1 : num;
        tabBarButton.frame = CGRectMake(itemW * tempNum, itemY, itemW, itemH);
        
        num++;
    }
}

/** 发布按钮点击 */
- (void)releaseBtnClick:(UIButton *)btn {
    
    // 获取主窗口来 modal 控制器
    HXLReleaseViewController *releaseVC = [[HXLReleaseViewController alloc] init];
    
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    UIViewController *rootVC = keyWindow.rootViewController;
    [rootVC presentViewController:releaseVC animated:NO completion:nil];
    
    NSLog(@"发布按钮点击");

}


/**
 发通知, tabBar 上的按钮被点击了
 */
- (void)postNotiClick:(UIButton *)btn {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HXLTabBarDidSelectNotification object:nil userInfo:nil];
}




@end

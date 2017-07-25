//
//  HXLPushGuideView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/22.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPushGuideView.h"


@implementation HXLPushGuideView
- (IBAction)knowedClose:(UIButton *)sender {
    
    [self removeFromSuperview];
}

// 创建对象
+ (instancetype)guideView
{
    return [self loadViewFormXib:0];
}

static NSString *versionKey = @"CFBundleShortVersionString";

+ (void)show
{
    // 读取当前版本, 对比偏好设置中记录的版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    NSString *preVersion = [[NSUserDefaults standardUserDefaults] stringForKey:versionKey];
    
    if ([currentVersion isEqualToString:preVersion]) return;
    
    // 是新版本就添加引导页, 并将新版本号保存到偏好设置中
    HXLPushGuideView *pushGuideView = [HXLPushGuideView guideView];
    [KEYWINDOW addSubview:pushGuideView];
    pushGuideView.frame = KEYWINDOW.bounds;
    
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end

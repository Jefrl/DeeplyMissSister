//
//  UIBarButtonItem+HXLBarBtnItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "UIBarButtonItem+HXLBarBtnItem.h"

@implementation UIBarButtonItem (HXLBarBtnItem)
/** 设置导航栏左右按钮的(图片类型) */
+ (instancetype)barButtonItemImage:(UIImage *)BGImage selectedImage:(UIImage *)selectedImage addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    // custom 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:BGImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    [btn sizeToFit];
    
    // 消除按钮监听点击范围过大的 bug;
    // custom view控件
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    // 创建 barBtnItem
    UIBarButtonItem *barBtnItem = [[self alloc] initWithCustomView:btnView];
    
    return barBtnItem;
}

/** 设置导航栏左右按钮(文字类型) */
+ (instancetype)barButtonItemTitle:(NSString *)title titltColor:(UIColor *)titleColor fontSize:(UIFont *)fontSize target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // custom 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    // btn.font 已废除
    btn.titleLabel.font = fontSize;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    // 消除按钮监听点击范围过大的 bug;
    // custom view控件
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    // 创建 barBtnItem
    UIBarButtonItem *barBtnItem = [[self alloc] initWithCustomView:btnView];
    
    return barBtnItem;
}

/** 设置导航栏左右按钮的(图片+文字类型) */
//+ (instancetype)barButtonItemImage:(UIImage *)BGImage selectedImage:(UIImage *)selectedImage title:(NSString *)title titltColor:(UIColor *)titleColor titltSelectColor:(UIColor *)titltSelectColor fontSize:(UIFont *)fontSize addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents forState:(UIControlState)state forEventState:(UIControlState)eventState {
//    
//    // custom 按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:BGImage forState:UIControlStateNormal];
//    [btn setImage:selectedImage forState:UIControlStateHighlighted];
//    [btn addTarget:target action:action forControlEvents:controlEvents];
//    [btn sizeToFit];
//    
//    // 消除按钮监听点击范围过大的 bug;
//    // custom view控件
//    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
//    [btnView addSubview:btn];
//    
//    // 创建 barBtnItem
//    UIBarButtonItem *barBtnItem = [[self alloc] initWithCustomView:btnView];
//    
//    return barBtnItem;
//}

@end

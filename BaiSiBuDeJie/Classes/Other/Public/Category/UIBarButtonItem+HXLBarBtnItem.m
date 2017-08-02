//
//  UIBarButtonItem+HXLBarButtonItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//
#import "UIBarButtonItem+HXLBarBtnItem.h"

@implementation UIBarButtonItem (HXLBarButtonItem)
/** 设置导航栏左右按钮的(图片类型) */
+ (instancetype)barButtonItemImage:(UIImage *)NormalImage
                     selectedImage:(UIImage *)selectedImage
                         addTarget:(id)target
                            action:(SEL)action
                 contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                  forControlEvents:(UIControlEvents)controlEvents
                   forcontrolState:(UIControlState)controlState
{
    // custom 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:NormalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:controlState];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    btn.contentEdgeInsets = contentEdgeInsets;
    [btn sizeToFit];
    
    // 消除按钮监听点击范围过大的 bug;
    // custom view控件
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    // 创建 BarButtonItem
    UIBarButtonItem *BarButtonItem = [[self alloc] initWithCustomView:btnView];
    
    return BarButtonItem;
}

/** 设置导航栏左右按钮(文字类型) */
+ (instancetype)barButtonItemTitle:(NSString *)title
                        titltColor:(UIColor *)titleColor
                titleSelectedColor:(UIColor *)titleSelectedColor
                          fontSize:(UIFont *)fontSize
                            target:(id)target
                            action:(SEL)action
                 contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                  forControlEvents:(UIControlEvents)controlEvents
                   forcontrolState:(UIControlState)controlState
{
    // custom 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    // btn.font 已废除
    btn.titleLabel.font = fontSize;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleSelectedColor forState:controlState];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    btn.contentEdgeInsets = contentEdgeInsets;
    [btn sizeToFit];
    // 消除按钮监听点击范围过大的 bug;
    // custom view控件
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    // 创建 BarButtonItem
    UIBarButtonItem *BarButtonItem = [[self alloc] initWithCustomView:btnView];
    
    return BarButtonItem;
}

/** 设置导航栏左右按钮的(图片+文字类型) */
+ (instancetype)barButtonItemImage:(UIImage *)NormalImage
                     selectedImage:(UIImage *)selectedImage
                             title:(NSString *)title
                        titltColor:(UIColor *)titleColor
                titleSelectedColor:(UIColor *)titleSelectedColor
                          fontSize:(UIFont *)fontSize
                         addTarget:(id)target
                            action:(SEL)action
                 contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                  forControlEvents:(UIControlEvents)controlEvents
                   forcontrolState:(UIControlState)controlState
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:NormalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateHighlighted];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = fontSize;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:WHITE_COLOR forState:controlState];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    [btn sizeToFit];
    // 这里的距离自行内部调整, 下次还是要把 btn 放到外面去, 好长啊;
    btn.contentEdgeInsets = contentEdgeInsets;
    btn.titleEdgeInsets = titleEdgeInsets; 
    
    UIView *barButtonView = [[UIView alloc] initWithFrame:btn.bounds];
    [barButtonView addSubview:btn];
    
    UIBarButtonItem *BarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButtonView];

    return BarButtonItem;
}
@end

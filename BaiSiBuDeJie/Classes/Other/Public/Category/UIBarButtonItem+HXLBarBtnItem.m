//
//  UIBarButtonItem+HXLBarBtnItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "UIBarButtonItem+HXLBarBtnItem.h"

@implementation UIBarButtonItem (HXLBarBtnItem)
/** 设置导航栏左右按钮的 */
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

@end

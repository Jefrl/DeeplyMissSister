//
//  UIBarButtonItem+HXLBarBtnItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HXLBarBtnItem)
/** 设置导航栏左右按钮的(图片类型) */
+ (instancetype)barButtonItemImage:(UIImage *)BGImage selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/** 设置导航栏左右按钮(文字类型) */
+ (instancetype)barButtonItemTitle:(NSString *)title titltColor:(UIColor *)titleColor fontSize:(UIFont *)fontSize target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end

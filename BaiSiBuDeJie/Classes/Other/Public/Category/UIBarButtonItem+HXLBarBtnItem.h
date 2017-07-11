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
+ (instancetype _Nullable )barButtonItemImage:(UIImage * _Nullable )NormalImage
                     selectedImage:(UIImage * _Nullable )selectedImage
                         addTarget:(id _Nullable )target
                            action:(SEL _Nullable )action
                 contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                  forControlEvents:(UIControlEvents)controlEvents
                   forcontrolState:(UIControlState)controlState;

/** 设置导航栏左右按钮(文字类型) */
+ (instancetype _Nullable )barButtonItemTitle:(NSString * _Nullable )title
                        titltColor:(UIColor * _Nullable )titleColor
                titleSelectedColor:(UIColor * _Nullable )titleSelectedColor
                          fontSize:(UIFont * _Nullable )fontSize
                            target:(id _Nullable )target
                            action:(SEL _Nullable )action
                 contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                  forControlEvents:(UIControlEvents)controlEvents
                   forcontrolState:(UIControlState)controlState;

/** 设置导航栏左右按钮的(图片+文字类型) */
+ (instancetype _Nullable )barButtonItemImage:(UIImage * _Nullable )NormalImage
                     selectedImage:(UIImage * _Nullable )selectedImage
                             title:(NSString * _Nullable )title
                        titltColor:(UIColor * _Nullable )titleColor
                titleSelectedColor:(UIColor * _Nullable )titleSelectedColor
                          fontSize:(UIFont * _Nullable )fontSize
                         addTarget:(id _Nullable )target
                            action:(SEL _Nullable )action
                 contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                  forControlEvents:(UIControlEvents)controlEvents
                   forcontrolState:(UIControlState)controlState;

@end

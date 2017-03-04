//
//  UIView+HXLGeometry.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/4.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXLGeometry)
// 分类如果扩展了属性, 那么要自己实现对应的 set, get 方法 

/** UIView.frame.origin.x */
@property (nonatomic, assign) CGFloat x;
/** UIView.frame.origin.y */
@property (nonatomic, assign) CGFloat y;
/** UIView.frame.size.width */
@property (nonatomic, assign) CGFloat width;
/** UIView.frame.size.height */
@property (nonatomic, assign) CGFloat height;
/** UIView.center.x */
@property (nonatomic, assign) CGFloat centerX;
/** UIView.center.y */
@property (nonatomic, assign) CGFloat centerY;

/** UIView.frame.origin.x */
@property (nonatomic, assign) CGFloat originX;
/** UIView.frame.origin.y */
@property (nonatomic, assign) CGFloat originY;
/** UIView.frame.size */
@property (nonatomic, assign) CGSize size;




@end
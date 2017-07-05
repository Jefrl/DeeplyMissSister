//
//  UIView+HXLGeometry.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/4.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "UIView+HXLGeometry.h"

@implementation UIView (HXLGeometry)
/** xib 的加载 */
+ (instancetype)loadViewFormXib:(NSInteger)index {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    return array[index];
}


/**
 当前 View 是否在主窗口上

 @return BOOL
 */
- (BOOL)isShowKeyWindow
{
    UIWindow *keyWindow = KEYWINDOW;
    // 将 View 的坐标 frame 的参照物从 superView 转换成主窗口为参照物的 newFrame;
    CGRect newFrame = [self.superview convertRect:self.frame toView:KEYWINDOW];
    // 判断是否有交叠部分;
    BOOL isIntersect = CGRectIntersectsRect(newFrame, keyWindow.bounds);
    
    BOOL flag = !self.isHidden && self.alpha > 0.01 && self.window == KEYWINDOW && isIntersect;
    
    return flag;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}




@end

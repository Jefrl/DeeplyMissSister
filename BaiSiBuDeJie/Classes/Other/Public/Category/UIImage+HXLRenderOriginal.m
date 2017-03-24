//
//  UIImage+HXLRenderOriginal.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "UIImage+HXLRenderOriginal.h"

@implementation UIImage (HXLRenderOriginal)

+ (UIImage *)imageRenderingModeAlwaysOriginal:(UIImage *)image
{
    
    UIImage *imageOrigin = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return imageOrigin;
}

+ (UIImage *)imageWithString:(NSString *)nameString
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: nameString]]];
    
    return image;
}

+ (UIImage *)imageCircleClipWithImage:(UIImage *)image
{
    // 开启图形上下文
    // 像素比例因子: 像素与点比例
    // 0:自动识别当前比例
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);

    // 描述圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 设置裁剪区域
    [path addClip];
    // 绘制图片
    [image drawAtPoint:CGPointZero];
    // 从上下文取出图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end

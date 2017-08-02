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

+ (UIImage *)imageResizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode imageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    // 取出用户自定义的系数
    CGFloat t = capInsets.top;
    CGFloat l = capInsets.left;
    CGFloat b = capInsets.bottom;
    CGFloat r = capInsets.right;
    // 创建用户子定义的系数后的图片内边距;
    CGFloat top = image.size.height * t;
    CGFloat left = image.size.width * l;
    CGFloat bottom = image.size.height * b - 1;
    CGFloat right = image.size.width * r - 1;
    UIEdgeInsets capInsetsNew = UIEdgeInsetsMake(top, left, bottom, right);
    // 拉伸图片
    UIImage *resizableImage = [image resizableImageWithCapInsets:capInsetsNew resizingMode:resizingMode];
    
    return resizableImage;
}

+ (NSData *)dataWithURLString:(NSString *)urlString
{
    return [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
}

+ (UIImage *)imageWithURLString:(NSString *)urlString
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]]];

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

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();

    return image;
}

@end

//
//  UIImage+HXLRenderOriginal.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HXLRenderOriginal)

/** 图片取消渲染 */
+ (UIImage *)imageRenderingModeAlwaysOriginal:(UIImage *)image;
/** 图片1*1拉伸 */
+ (UIImage *)imageResizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode imageNamed:(NSString *)name;
/** 由 URL字符串获取二进制流 */
+ (NSData *)dataWithURLString:(NSString *)urlString;
/** 由字符串获取网络图片 */
+ (UIImage *)imageWithURLString:(NSString *)urlString;
/** 圆形图片的裁剪 */
+ (UIImage *)imageCircleClipWithImage:(UIImage *)image;
/** 用颜色画一张图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

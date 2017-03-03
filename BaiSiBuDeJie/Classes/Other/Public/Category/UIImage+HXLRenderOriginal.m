//
//  UIImage+HXLRenderOriginal.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "UIImage+HXLRenderOriginal.h"

@implementation UIImage (HXLRenderOriginal)

+ (UIImage *)imageRenderingModeAlwaysOriginal:(UIImage *)image {
    
    UIImage *imageOrigin = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return imageOrigin;
}
@end

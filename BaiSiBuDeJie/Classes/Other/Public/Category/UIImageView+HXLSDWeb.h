//
//  UIImageView+HXLSDWeb.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/23.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HXLSDWeb)
/** 网络图片是否切圆 & 占位 */
- (void)setImageString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage circleImage:(BOOL)isYes;

@end

//
//  UIImageView+HXLSDWeb.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/23.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "UIImageView+HXLSDWeb.h"
#import "UIimageView+WebCache.h"

@implementation UIImageView (HXLSDWeb)
- (void)setImageString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage circleImage:(BOOL)isYes
{
    
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    if (!isYes) {
        [self sd_setImageWithURL:imageUrl placeholderImage:placeholderImage];
    } else {
        
        [self sd_setImageWithURL:imageUrl placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            // 获取圆形头像
            UIImage *circleImage = [UIImage imageCircleClipWithImage:image];
            // 赋值给控件
            self.image = circleImage;
        }];
    }
}
@end

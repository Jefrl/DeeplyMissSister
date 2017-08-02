//
//  HXLPostButton.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/7.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPostButton.h"

@implementation HXLPostButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:GRAY_COLOR forState:UIControlStateDisabled];
        [self setTitleColor:RED_COLOR forState:UIControlStateNormal];
        [self setTitleColor:RGBColor(122, 0, 0, 1) forState:UIControlStateHighlighted];
        self.titleLabel.font = FONT_12;
    }
    
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // btn 中 imageView 的形位
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.height;
    
    // btn 中的 label 的形位
    CGFloat space = 0;
    self.titleLabel.size = CGSizeMake(self.imageView.width - 2*space, self.imageView.height - 2*space);
    self.titleLabel.center = self.imageView.center;
}

@end

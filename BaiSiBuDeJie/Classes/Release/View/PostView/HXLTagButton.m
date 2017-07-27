//
//  HXLTagButton.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/27.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLTagButton.h"

@implementation HXLTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * DIY;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = DIY;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + DIY;
    
}

@end

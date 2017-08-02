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
        self.titleLabel.font = FONT_12;
        [self setBackgroundColor:RGBColor(60, 120, 200, 1)];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.height = 3 *essenceMargin_x;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * DIY;
    self.height = 3 *essenceMargin_x;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = DIY;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + DIY;
    
}

@end

//
//  HXLSquareButton.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSquareButton.h"
#import "HXLSquareItem.h"
#import "UIButton+WebCache.h"

@implementation HXLSquareButton
static const NSInteger btnInsideSpace = 10;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.titleLabel.font = FONT_13;
    }
    
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // btn 中 imageView 的形位
    self.imageView.y = btnInsideSpace;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // btn 中的 label 的形位
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.x = 0;
}

- (void)setSquareItem:(HXLSquareItem *)squareItem
{
    _squareItem = squareItem;
    NSLog(@"%@", squareItem.name);
    
    [self sd_setImageWithURL:[NSURL URLWithString:squareItem.icon] forState:UIControlStateNormal placeholderImage:nil];
    
    [self setTitle:squareItem.name forState:UIControlStateNormal];
    
}

@end

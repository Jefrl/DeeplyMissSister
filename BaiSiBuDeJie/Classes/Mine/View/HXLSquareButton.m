//
//  HXLSquareButton.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSquareButton.h"
#import "HXLSquareItem.h"
#import "UIImageView+HXLSDWeb.h"

@implementation HXLSquareButton
static const NSInteger btnInsideSpace = 10;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = CYAN_COLOR;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.titleLabel.font = FONT_13;
    }
    
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    // btn 中 imageView 的形位
//    self.imageView.x = btnInsideSpace;
//    self.imageView.y = btnInsideSpace;
//    self.imageView.width = self.width - (btnInsideSpace * 2);
//    self.imageView.height = self.imageView.width;
//    
//    // btn 中的 label 的形位
//    self.titleLabel.x = self.imageView.x;
//    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + btnInsideSpace;
//    self.titleLabel.width = self.imageView.width;
//    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquareItem:(HXLSquareItem *)squareItem
{
    _squareItem = squareItem;
    NSLog(@"%@", squareItem.name);
    
    [self.imageView setImageString:squareItem.icon placeholderImage:nil circleImage:NO];
    [self setTitle:@"name" forState:UIControlStateNormal];
    
}

@end

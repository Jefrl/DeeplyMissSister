//
//  HXLProgressView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/6/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLProgressView.h"

@implementation HXLProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.roundedCorners = 3;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


@end

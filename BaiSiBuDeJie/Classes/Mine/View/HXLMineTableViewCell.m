//
//  HXLMineTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineTableViewCell.h"

@implementation HXLMineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.backgroundView = backgroundView;
        
        self.textLabel.font = FONT_17;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) {
        return;
    }
    
    self.imageView.x = essenceMargin_x;
    self.imageView.width = essenceMargin_x * 3;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + essenceMargin_x;
}

- (void)setFrame:(CGRect)frame
{ //  NSLog(@"%@", NSStringFromCGRect(frame));
    
    [super setFrame:frame];
}

@end

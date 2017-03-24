//
//  HXLPunTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPunTableViewCell.h"
#import "HXLEssenceItem.h"
#import "UIImageView+HXLSDWeb.h"

@interface HXLPunTableViewCell ()
//@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
//@property (weak, nonatomic) IBOutlet UILabel *usr_label;
//@property (weak, nonatomic) IBOutlet UILabel *time_label;
//@property (weak, nonatomic) IBOutlet UIImageView *vip_imageView;
//@property (weak, nonatomic) IBOutlet UIImageView *jewel_imageView;


@end

@implementation HXLPunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = WHITE_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.x += 10;
    self.contentView.y += 10;
    self.contentView.width -= 20;
    self.contentView.height -= 10;

}

- (void)setPunCellItem:(HXLEssenceItem *)punCellItem
{
    _punCellItem = punCellItem;
    [_icon_imageView setImageString:punCellItem.profile_image placeholderImage:[UIImage imageNamed:@"default_header_image_small"] circleImage:YES];
    
    _time_label.text = punCellItem.create_at;
    _usr_label.text = punCellItem.name;
    _text_label.textAlignment = NSTextAlignmentLeft;
    _text_label.text = punCellItem.text;
    _firstHot_label.text = @"胡汉三: 我又回来我又回来我又回来我又回来我又回来我又回来";
    _secondHot_label.text = @"胡汉三: 我又回1234asdffffffffffffffasfd";
    _thirdHot_label.text = @"胡汉三: 我又回来asfdasdf";
}

- (void)setFrame:(CGRect)frame {
//    frame.origin.x += 10;
//    frame.origin.y += 10;
//    frame.size.width -= 20;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end

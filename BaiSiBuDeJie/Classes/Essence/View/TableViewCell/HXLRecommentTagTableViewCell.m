//
//  HXLRecommentTagTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/20.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLRecommentTagTableViewCell.h"
#import "HXLRecommentTagItem.h"

#import "UIImageView+HXLSDWeb.h"

@interface HXLRecommentTagTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;


@end

@implementation HXLRecommentTagTableViewCell
- (IBAction)followBtnClick:(UIButton *)sender {
        sender.selected = !sender.selected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setRecommentTagItem:(HXLRecommentTagItem *)recommentTagItem
{
    _recommentTagItem = recommentTagItem;
    [self.iconImageView setImageString:_recommentTagItem.image_list placeholderImage:[UIImage imageNamed:@"default_header_image_small"] circleImage:YES];
    
    self.nameLabel.text = _recommentTagItem.theme_name;
    self.followLabel.text = [NSString stringWithFormat:@"%@人订阅", [NSString stringFansFollowWithString:_recommentTagItem.sub_number]];
    
}

@end

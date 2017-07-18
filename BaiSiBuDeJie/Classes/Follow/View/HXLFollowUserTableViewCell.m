//
//  HXLFollowUserTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLFollowUserTableViewCell.h"
#import "HXLFollowUserItem.h"

#import "UIImageView+HXLSDWeb.h"

@interface HXLFollowUserTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;


@end

@implementation HXLFollowUserTableViewCell
- (IBAction)followBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
//    if (!sender.selected) {
//        [sender setTitle:@"已关注" forState:UIControlStateNormal];
//        
//    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setUserItem:(HXLFollowUserItem *)userItem
{
    _userItem = userItem;
    [self.iconImageView setImageString:_userItem.header placeholderImage:[UIImage imageNamed:@"default_header_image_small"] circleImage:YES];
    
    self.nameLabel.text = _userItem.screen_name;
    self.followLabel.text = [NSString stringFansFollowWithString:_userItem.fans_count];
    
}


@end

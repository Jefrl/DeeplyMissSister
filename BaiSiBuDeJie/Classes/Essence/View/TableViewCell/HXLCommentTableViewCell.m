//
//  HXLCommentTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/8.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLCommentTableViewCell.h"
#import "HXLEssenceCommentItem.h"
#import "HXLUser.h"

#import "UIImageView+HXLSDWeb.h"

@interface HXLCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *nameImageV;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageV;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *DingCounts;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** user 信息 */
@property (nonatomic, readwrite, strong) HXLUser *user;

@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *voicetime;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;


@end

@implementation HXLCommentTableViewCell
- (IBAction)voiceBtnClick:(UIButton *)sender {
    NSLog(@"..");
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setCommentItem:(HXLEssenceCommentItem *)commentItem
{
    // 基础信息设置
    _commentItem = commentItem;
    
    self.user = _commentItem.user;
    [self.nameImageV setImageString:_user.profile_image placeholderImage:[UIImage imageNamed:@"default_header_image_small"] circleImage:YES];
    if ([_user.sex isEqualToString:@"f"]) {
        self.sexImageV.image = [UIImage imageNamed:@"Profile_womanIcon"];
    } else {
        self.sexImageV.image = [UIImage imageNamed:@"Profile_manIcon"];
    }
    self.DingCounts.text = _user.total_cmt_like_count;
    self.name.text = _user.username;
    
    if (HXLTopicTypeVoice == _commentItem.cmt_type.integerValue) {
        self.voiceView.hidden = NO;
        self.comment.hidden = YES;
        
        self.voicetime.text = [NSString stringWithFormat:@"%@\"",  _commentItem.voicetime];
    } else {
        self.voiceView.hidden = YES;
        self.comment.hidden = NO;
        self.comment.text = _commentItem.content;
    }
    
    self.dingBtn.titleLabel.text = _commentItem.like_count;
}


@end

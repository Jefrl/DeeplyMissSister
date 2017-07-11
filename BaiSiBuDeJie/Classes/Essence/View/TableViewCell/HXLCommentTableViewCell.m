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
@property (weak, nonatomic) IBOutlet UILabel *ctime;


@end

@implementation HXLCommentTableViewCell
- (IBAction)dingBtnClick:(UIButton *)sender {
    
    [self dingOrCaiBtnClick:sender otherBtn:self.caiBtn];
    
}
- (IBAction)caiBtnClick:(UIButton *)sender {
    
    [self dingOrCaiBtnClick:sender otherBtn:self.dingBtn];
}
- (IBAction)voiceBtnClick:(UIButton *)sender {
    NSLog(@"");
//    UIWebView *web = [[UIWebView alloc] initWithFrame:SCREEN_BOUNDS];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.commentItem.voiceuri]]];
//    [KEYWINDOW addSubview:web];
    
}

- (void)dingOrCaiBtnClick:(UIButton *)sender otherBtn:(UIButton *)otherBtn
{
    if (sender.isSelected || otherBtn.isSelected) {
        return;
    }
    sender.selected = YES;
    NSString *countString = [NSString stringWithFormat:@"%ld", ([sender.titleLabel.text integerValue] + 1)];
    [sender setTitle:countString forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

#pragma mark - UIMenuController
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
//    if(action == @selector(cut:) || action == @selector(copy:) || action == @selector(myCut:)|| action == @selector(myPaste:)) return YES;
    return NO;
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
    
    if (HXLTopicTypeVoice == _commentItem.cmt_type.integerValue) { // 是音频评论
        self.voiceView.hidden = NO;
        self.comment.hidden = YES;
        
        self.voicetime.text = [NSString stringWithFormat:@"%@\"",  _commentItem.voicetime];
    } else { // 是文字评论
        self.voiceView.hidden = YES;
        self.comment.hidden = NO;
        self.comment.text = _commentItem.content;
    }
    
    self.ctime.text = _commentItem.ctime;
    [self.dingBtn setTitle:_commentItem.like_count forState:UIControlStateNormal];
}


@end

/** 测试数据
 commentItem.cmt_type = @"31";
 commentItem.voicetime = @"10000";
 commentItem.voiceuri = @"www.baidu.com";
 */


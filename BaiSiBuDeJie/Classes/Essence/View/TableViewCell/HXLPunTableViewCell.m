//
//  HXLPunTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPunTableViewCell.h"
#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"
#import "HXLUser.h"

#import "UIImageView+HXLSDWeb.h"
#import "HXLPictureTableViewCell.h"
#import "HXLVideoTableViewCell.h"
#import "HXLVoiceTableViewCell.h"

@interface HXLPunTableViewCell ()
//@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
//@property (weak, nonatomic) IBOutlet UILabel *usr_label;
//@property (weak, nonatomic) IBOutlet UILabel *time_label;
//@property (weak, nonatomic) IBOutlet UIImageView *vip_imageView;
//@property (weak, nonatomic) IBOutlet UIImageView *jewel_imageView;

/** picView */
@property (nonatomic, weak) HXLPictureTableViewCell *pictureView;
/** videoView */
@property (nonatomic, weak) HXLVideoTableViewCell *videoView;
/** voiceView */
@property (nonatomic, weak) HXLVoiceTableViewCell *voiceView;
/** likeBtn */
@property (nonatomic, weak) IBOutlet UIButton *likeBtn;
/** dislikeBtn */
@property (nonatomic, weak) IBOutlet UIButton *dislikeBtn;
/** shareBtn */
@property (nonatomic, weak) IBOutlet UIButton *shareBtn;
/** commentBtn */
@property (nonatomic, weak) IBOutlet UIButton *commentBtn;




@end

@implementation HXLPunTableViewCell
- (IBAction)like:(UIButton *)sender {
    NSInteger count = [sender.titleLabel.text integerValue];
    NSString *newCount = [NSString stringWithFormat:@"%ld", ++count];
    [sender setTitle:newCount forState:UIControlStateNormal];
}

- (IBAction)dislike:(UIButton *)sender {
    NSInteger count = [sender.titleLabel.text integerValue];
    NSString *newCount = [NSString stringWithFormat:@"%ld", --count];
    [sender setTitle:newCount forState:UIControlStateNormal];
}

- (IBAction)share:(UIButton *)sender {
    NSLog(@"");
}

- (IBAction)comment:(UIButton *)sender {
    NSLog(@"");
}

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

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    [super setFrame:frame];
}

#pragma mark - 懒加载
- (HXLPictureTableViewCell *)pictureView {
    if (!_pictureView) {
        HXLPictureTableViewCell *pictureView = [HXLPictureTableViewCell loadViewFormXib:0];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (HXLVideoTableViewCell *)videoView {
    if (!_videoView) {
        HXLVideoTableViewCell *videoView = [HXLVideoTableViewCell loadViewFormXib:0];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (HXLVoiceTableViewCell *)voiceView {
    if (!_voiceView) {
        HXLVoiceTableViewCell *voiceView = [HXLVoiceTableViewCell loadViewFormXib:0];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

#pragma mark - 01 模型设置
- (void)setPunCellItem:(HXLEssenceItem *)punCellItem
{
    // 通用的基类 cell 属性设置;
    _punCellItem = punCellItem;
    [_icon_imageView setImageString:punCellItem.profile_image placeholderImage:[UIImage imageNamed:@"default_header_image_small"] circleImage:YES];
    _time_label.text = punCellItem.create_at;
    _usr_label.text = punCellItem.name;
    _text_label.textAlignment = NSTextAlignmentLeft;
    _text_label.text = punCellItem.text;
    
    // 顶赞部分
    [_likeBtn setTitle:_punCellItem.ding forState:UIControlStateNormal];
    [_dislikeBtn setTitle:_punCellItem.cai forState:UIControlStateNormal];
    [_shareBtn setTitle:_punCellItem.repost forState:UIControlStateNormal];
    [_commentBtn setTitle:_punCellItem.comment forState:UIControlStateNormal];

    // 设置前3条热评的数据
    NSArray *labelArray = @[_firstHot_label, _secondHot_label, _thirdHot_label];
    [punCellItem.hotArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXLEssenceCommentItem *item = obj;
        HXLUser *user = item.user;
        UILabel *label = labelArray[idx];
        
        NSString *content = [NSString stringWithFormat:@"%@: %@", user.username, item.content];
        label.text = content;
        label.hidden = NO;
        
        if (idx == showHotCount - 1) {
            *stop = YES;
        }
    }];
    
    // 区分类别添加控件
    if (_punCellItem.type == HXLTopicTypePicture) { // 传入的模型是图片模型
//        self.pictureView.
        [self setupCellTypesView:self.pictureView hiddenViews:@[self.videoView, self.voiceView] viewFrame:_punCellItem.pictureFrame];
    } else if (_punCellItem.type == HXLTopicTypeVideo) { // 视频模型
        
        [self setupCellTypesView:self.videoView hiddenViews:@[self.pictureView, self.voiceView] viewFrame:_punCellItem.videoFrame];
    } else if (_punCellItem.type == HXLTopicTypeVoice) { // 音频模型
        
        [self setupCellTypesView:self.voiceView hiddenViews:@[self.videoView, self.pictureView] viewFrame:_punCellItem.voiceFrame];
    } else { // 段子
        [self setupCellTypesView:nil hiddenViews:@[self.pictureView, self.videoView, self.voiceView] viewFrame:CGRectNull];
    }

}

/** 不同类型 cell 的加载 */
- (void)setupCellTypesView:(UIView *)displayView hiddenViews:(NSArray *)hiddenViews viewFrame:(CGRect)viewFrame {
    displayView.hidden = NO;
    displayView.frame = viewFrame;
    
    for (UIView *view in hiddenViews) {
        view.hidden = YES;
    }
    
}

@end


    
    
    
    
    
    
    
    

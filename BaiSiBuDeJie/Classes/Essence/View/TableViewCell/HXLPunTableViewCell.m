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
#import "HXLPictureView.h"
#import "HXLVideoTableViewCell.h"
#import "HXLVoiceTableViewCell.h"

@interface HXLPunTableViewCell ()

///** 热评三 */
//@property (weak, nonatomic) IBOutlet UILabel *thirdHot_label;
///** mid 到bottom 控件的约束 */
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_midToBottomTop;
///** mid 到父控件的约束 */
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containConstraint_midToSuperBottom;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondlabel_layoutToThird;

/** picView */
@property (nonatomic, weak) HXLPictureView *pictureView;
/** videoView */
@property (nonatomic, weak) HXLVideoTableViewCell *videoView;
/** voiceView */
@property (nonatomic, weak) HXLVoiceTableViewCell *voiceView;

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *usr_label;
/** 发布时间 */
@property (weak, nonatomic) IBOutlet UILabel *time_label;
/** 加 V  */
@property (weak, nonatomic) IBOutlet UIImageView *vip_imageView;
/** 加钻 */
@property (weak, nonatomic) IBOutlet UIImageView *jewel_imageView;
/** 描述文字 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

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
#pragma mark - 懒加载
- (HXLPictureView *)pictureView {
    if (!_pictureView) {
        HXLPictureView *pictureView = [HXLPictureView loadViewFormXib:0];
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

#pragma mark - UIButton
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

#pragma mark - init zone
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self. contentView.backgroundColor = WHITE_COLOR;
    self.backgroundColor = RGBColor(204, 204, 204, 1);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.x = DIY;
    self.contentView.y = DIY;
    self.contentView.width = self.width - DIY * 2;
    self.contentView.height = self.height - DIY * 2;
    // 非 Xib 加载的子控件 midView.frame
    self.pictureView.frame = self.punCellItem.pictureFrame;
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = DIY;
    frame.origin.y += DIY;
    
    frame.size.width = SCREEN_WIDTH - DIY * 2;
    // 为了花哨, 我故意不乘以 2 了; 所以前面的cell 高度应该, 只增加15;
    frame.size.height = self.punCellItem.cellHeight - DIY;
    
    [super setFrame:frame];
}

#pragma mark - 01 模型设置
- (void)setPunCellItem:(HXLEssenceItem *)punCellItem
{
    // 通用的基类 cell 属性设置;
    _punCellItem = punCellItem;
    [_icon_imageView setImageString:punCellItem.profile_image placeholderImage:[UIImage imageNamed:@"default_header_image_small"] circleImage:YES];
    _time_label.text = punCellItem.created_at;
    _usr_label.text = punCellItem.name;
    _text_label.textAlignment = NSTextAlignmentLeft;
    _text_label.text = punCellItem.text;
    
    // 顶赞部分设置
    [_likeBtn setTitle:_punCellItem.ding forState:UIControlStateNormal];
    [_dislikeBtn setTitle:_punCellItem.cai forState:UIControlStateNormal];
    [_shareBtn setTitle:_punCellItem.repost forState:UIControlStateNormal];
    [_commentBtn setTitle:_punCellItem.comment forState:UIControlStateNormal];

    // 热评控件设置
    
    // 区分类别添加控件
    if (_punCellItem.type == HXLTopicTypePicture) { // 传入的模型是图片模型
        
        [self setupMidView:self.pictureView cellItem:_punCellItem hiddenMidViews:@[self.videoView, self.voiceView]];
        
        
    } else if (_punCellItem.type == HXLTopicTypeVideo) { // 视频模型
        
//        [self setupMidView:self.videoView cellItem:_punCellItem hiddenMidViews:@[self.pictureView, self.voiceView]];

    } else if (_punCellItem.type == HXLTopicTypeVoice) { // 音频模型
        
//        [self setupCellTypesView:self.voiceView hiddenViews:@[self.videoView, self.pictureView] viewFrame:_punCellItem.voiceFrame];
    } else { // 段子
//        [self setupCellTypesView:nil hiddenViews:@[self.pictureView, self.videoView, self.voiceView] viewFrame:CGRectNull];
    }

}

/** 不同类型 cell 的加载 */
- (void)setupMidView:(UIView *)displayView cellItem:(HXLEssenceItem *)punCellItem hiddenMidViews:(NSArray *)hiddenViews {
    
    displayView.punCellItem = punCellItem;
    
    [self.contentView addSubview:displayView];
    
    displayView.hidden = NO;
    for (UIView *view in hiddenViews) {
        view.hidden = YES;
    }
    
    // !切记: 不能在这里计算 frame, midView 因为类型多种, 所以作为另一个 xib 控件加载到 cell 内部, cell 是自定义, 自定义控件的内部子控件的 frame, 要么已经在xib 上布局好了, 要么走 layoutsubViews 方法;
    //    displayView.frame = viewFrame;
    
}

@end


    
    
    
    
// =======dev=============
    
    
    

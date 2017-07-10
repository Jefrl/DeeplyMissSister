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
#import "HXLVideoView.h"
#import "HXLVoiceView.h"

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
@property (nonatomic, weak) HXLVideoView *videoView;
/** voiceView */
@property (nonatomic, weak) HXLVoiceView *voiceView;

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

- (HXLVideoView *)videoView {
    if (!_videoView) {
        HXLVideoView *videoView = [HXLVideoView loadViewFormXib:0];
        _videoView = videoView;
    }
    return _videoView;
}

- (HXLVoiceView *)voiceView {
    if (!_voiceView) {
        HXLVoiceView *voiceView = [HXLVoiceView loadViewFormXib:0];
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

#pragma mark - Init zone
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self. contentView.backgroundColor = WHITE_COLOR;
    self.backgroundColor = GRAY_PUBLIC_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.x = DIY;
    self.contentView.y = DIY;
    self.contentView.width = self.width - DIY * 2;
    self.contentView.height = self.height - DIY * 2;
    // 非 cell 的 Xib 本身上子控件 midView.frame 的设定
    self.pictureView.frame = self.punCellItem.pictureFrame;
    self.videoView.frame = self.punCellItem.pictureFrame;
    self.voiceView.frame = self.punCellItem.pictureFrame;
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = DIY;
    frame.origin.y += DIY;
    
    frame.size.width = SCREEN_WIDTH - DIY * 2;
    // 为了花哨, 我故意不乘以 2 了; 所以前面的cell 高度应该, 只增加15;
    frame.size.height = self.punCellItem.cellHeight - DIY;
    
    [super setFrame:frame];
}

#pragma mark - 模型属性的赋值
- (void)setPunCellItem:(HXLEssenceItem *)punCellItem
{
    // cell 通用的基础类属性设置;
    [self setupUniformStyle:punCellItem];

    // 热评控件设置
    
    // 不同类型的 MidView 控件的添加
    if (_punCellItem.type == HXLTopicTypePicture) { // 传入的模型是图片模型
        
        [self setupMidView:self.pictureView cellItem:_punCellItem hiddenMidViews:@[self.videoView, self.voiceView]];
        
        
    } else if (_punCellItem.type == HXLTopicTypeVideo) { // 视频模型
        
        [self setupMidView:self.videoView cellItem:_punCellItem hiddenMidViews:@[self.pictureView, self.voiceView]];

    } else if (_punCellItem.type == HXLTopicTypeVoice) { // 音频模型
        
        [self setupMidView:self.voiceView cellItem:_punCellItem hiddenMidViews:@[self.videoView, self.pictureView]];
        
    } else { // 段子
        
        [self setupMidView:nil cellItem:nil hiddenMidViews:@[self.voiceView, self.videoView, self.pictureView]];
    }

}

#pragma mark - 优化抽取的方法
- (void)setupUniformStyle:(HXLEssenceItem *)punCellItem
{
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
}

/** 不同类型 cell 的加载 */
- (void)setupMidView:(UIView *)displayView cellItem:(HXLEssenceItem *)punCellItem hiddenMidViews:(NSArray *)hiddenViews {
    
    displayView.punCellItem = punCellItem;
    
    [self.contentView addSubview:displayView];
    
    displayView.hidden = NO;
    
    // 添加到cell 之前, 要将重用 cell 的 midView 上的内容隐藏或移除
    for (UIView *view in hiddenViews) {
        view.hidden = YES;
    }
    
    [hiddenViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // !切记: 不能在这里计算 frame, midView 因为类型多种, 所以作为另一个 xib 控件加载到 cell 内部, cell 是自定义, 自定义控件的内部子控件的 frame, 要么已经在xib 上布局好了, 要么走 layoutsubViews 方法;
    //    displayView.frame = viewFrame;
    
}

@end


    
    
    
    
// =======dev=============
    
    
    

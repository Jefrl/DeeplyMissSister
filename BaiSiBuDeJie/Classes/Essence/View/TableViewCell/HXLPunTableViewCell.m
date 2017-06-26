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

/** picView */
@property (nonatomic, weak) HXLPictureTableViewCell *pictureView;
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
/** 头像控件 */
@property (weak, nonatomic) IBOutlet UIView *containBottomView;
/** 热评一 */
@property (weak, nonatomic) IBOutlet UILabel *firstHot_label;
/** 热评二 */
@property (weak, nonatomic) IBOutlet UILabel *secondHot_label;
/** 热评三 */
@property (weak, nonatomic) IBOutlet UILabel *thirdHot_label;
/** mid 到bottom 控件的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_midToBottomTop;
/** mid 到父控件的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containConstraint_midToSuperBottom;
/** likeBtn */
@property (nonatomic, weak) IBOutlet UIButton *likeBtn;
/** dislikeBtn */
@property (nonatomic, weak) IBOutlet UIButton *dislikeBtn;
/** shareBtn */
@property (nonatomic, weak) IBOutlet UIButton *shareBtn;
/** commentBtn */
@property (nonatomic, weak) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabel_layoutToSuper;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstlabel_layoutToSecond;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondlabel_layoutToSuper;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondlabel_layoutToThird;




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
    
    self.backgroundColor = GRAY_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.x = 10;
    self.contentView.y = 10;
    self.contentView.width = SCREEN_WIDTH - 20;
    self.contentView.height = self.punCellItem.cellHeight - essenceMargin_y - cellMargin_y;
    
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height = self.punCellItem.cellHeight - cellMargin_y;
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
    NSArray *hotLabelArray = @[_firstHot_label, _secondHot_label, _thirdHot_label];
    if (punCellItem.top_cmt.count == 0) { // 不存在热评模型;
        // 无热评则让到热评的约束失效, 并激活到父控件 contentView 的约束
        self.containBottomView.hidden = YES;
        self.containConstraint_midToSuperBottom.active = YES;
        self.constraint_midToBottomTop.active = NO;
    } else { // 存在热评模型
        self.containBottomView.hidden = NO;
        self.containConstraint_midToSuperBottom.active = NO;
        self.constraint_midToBottomTop.active = YES;
        // 先恢复原有约束
        [hotLabelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = obj;
            label.hidden = YES;
            if (idx == 0) {
                _firstLabel_layoutToSuper.active = NO;
                _firstlabel_layoutToSecond.active = YES;
            }
            if (idx == 1) {
                _secondlabel_layoutToSuper.active = NO;
                _secondlabel_layoutToThird.active = YES;
            }
        }];
        
        // 设置对应约束
        [punCellItem.top_cmt enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 取出一一对应idx 的 label 赋值
            HXLEssenceCommentItem *item = obj;
            HXLUser *user = item.user;
            UILabel *label = hotLabelArray[idx];
            NSString *content = [NSString stringWithFormat:@"%@: %@", user.username, item.content];
            label.text = content;
            label.hidden = NO;
            
            if (idx == punCellItem.maxIndex) {
                *stop = YES;
                if (idx == 0) { // 激活第一个, 失效第三个的约束;
                    _firstLabel_layoutToSuper.active = YES;
                    _firstlabel_layoutToSecond.active = NO;
                }
                if (idx == 1) { // 激活第二个, 失效第三个
                    _secondlabel_layoutToSuper.active = YES;
                    _secondlabel_layoutToThird.active = NO;
                }
            }
        }];
    }
    
    // 区分类别添加控件
    if (_punCellItem.type == HXLTopicTypePicture) { // 传入的模型是图片模型
        
        [self setupCellTypesView:self.pictureView punCellItem:_punCellItem hiddenViews:@[self.videoView, self.voiceView] viewFrame:_punCellItem.pictureFrame];
    } else if (_punCellItem.type == HXLTopicTypeVideo) { // 视频模型
        
//        [self setupCellTypesView:self.videoView hiddenViews:@[self.pictureView, self.voiceView] viewFrame:_punCellItem.videoFrame];
    } else if (_punCellItem.type == HXLTopicTypeVoice) { // 音频模型
        
//        [self setupCellTypesView:self.voiceView hiddenViews:@[self.videoView, self.pictureView] viewFrame:_punCellItem.voiceFrame];
    } else { // 段子
//        [self setupCellTypesView:nil hiddenViews:@[self.pictureView, self.videoView, self.voiceView] viewFrame:CGRectNull];
    }

}

/** 不同类型 cell 的加载 */
- (void)setupCellTypesView:(UITableViewCell *)displayView punCellItem:(HXLEssenceItem *)punCellItem hiddenViews:(NSArray *)hiddenViews viewFrame:(CGRect)viewFrame {
    
    displayView.punCellItem = punCellItem;
    displayView.hidden = NO;
    displayView.frame = viewFrame;
    
    for (UIView *view in hiddenViews) {
        view.hidden = YES;
    }
    
    
}

@end


    
    
    
    
    
    
    
    

//
//  HXLPunTableViewCell.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXLEssenceItem;

@interface HXLPunTableViewCell : UITableViewCell
/** cell 模型 */
@property (nonatomic, strong) HXLEssenceItem *punCellItem;
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



@end

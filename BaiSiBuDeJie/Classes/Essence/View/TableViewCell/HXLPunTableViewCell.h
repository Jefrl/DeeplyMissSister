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

@property (weak, nonatomic) IBOutlet UIImageView *icon_imageView;
@property (weak, nonatomic) IBOutlet UILabel *usr_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UIImageView *vip_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *jewel_imageView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIView *containBottomView;
@property (weak, nonatomic) IBOutlet UILabel *firstHot_label;
@property (weak, nonatomic) IBOutlet UILabel *secondHot_label;
@property (weak, nonatomic) IBOutlet UILabel *thirdHot_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_midToBottomTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containConstraint_midToSuperBottom;


@end

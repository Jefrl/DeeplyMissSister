//
//  HXLSettingTableViewCell.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXLSettingBaseItem;

@interface HXLSettingTableViewCell : UITableViewCell

/** settingItem */
@property (nonatomic, readwrite, strong) HXLSettingBaseItem *settingItem;
/** 获取 cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

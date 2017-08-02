//
//  HXLSettingTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSettingTableViewCell.h"
#import "HXLSettingBaseItem.h"
#import "HXLSettingArrowItem.h"
#import "HXLSettingSwitchItem.h"
#import "HXLSettingSegmentedItem.h"

@interface HXLSettingTableViewCell ()

@end

@implementation HXLSettingTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    HXLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingReuseID];
    cell = [[HXLSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingReuseID];
    
    
    return cell;
}

- (void)setSettingItem:(HXLSettingBaseItem *)settingItem
{
    _settingItem = settingItem;
    self.textLabel.text = settingItem.title;
    self.detailTextLabel.text = settingItem.detailTitle;
    self.imageView.image = [UIImage imageNamed:settingItem.icon];
    
    if ([self.settingItem isKindOfClass:[HXLSettingSegmentedItem class]]) {
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"小", @"中", @"大"]];
        segment.selectedSegmentIndex = 1;
        self.accessoryView = segment;
    } else if ([self.settingItem isKindOfClass:[HXLSettingSwitchItem class]]) {
        UISwitch *sw = [[UISwitch alloc] init];
        sw.on = self.isOpaque;
        self.accessoryView = sw;
        
    } else if ([self.settingItem isKindOfClass:[HXLSettingArrowItem class]] ) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSLogTest;
    } else { // 其他没有附件控件的要清空, 由于有循环使用;
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
        
    }
}



@end

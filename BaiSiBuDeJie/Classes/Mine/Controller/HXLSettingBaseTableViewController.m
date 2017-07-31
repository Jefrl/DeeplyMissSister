//
//  HXLSettingBaseTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/31.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSettingBaseTableViewController.h"

#import "HXLSettingTableViewCell.h"
#import "HXLArrowTableViewController.h"

#import "HXLSettingGroupItem.h"
#import "HXLSettingBaseItem.h"
#import "HXLSettingArrowItem.h"
#import "HXLSettingSwitchItem.h"
#import "HXLSettingSegmentedItem.h"

#import "SDImageCache.h"
#import "MJExtension.h"

@interface HXLSettingBaseTableViewController ()


@end

@implementation HXLSettingBaseTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 响应的方法区域

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groupBaseArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    HXLSettingGroupItem *group = (section == 0) ? self.groupBaseArray[0] : self.groupBaseArray[1];
    return group.settingItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXLSettingTableViewCell *cell = [HXLSettingTableViewCell cellWithTableView: tableView];
    cell.textLabel.font = FONT_14;
    
    HXLSettingGroupItem *group = (indexPath.section == 0) ? self.groupBaseArray[0] : self.groupBaseArray[1];
    HXLSettingSwitchItem *item = group.settingItemArray[indexPath.row];
    
    cell.settingItem = item;
    
    if (item.title == nil) { // 如果是清除缓存的 cell
        CGFloat cacheSize = [SDImageCache sharedImageCache].getSize / 1000.0 /1000;
        NSString *title01 = [NSString stringWithFormat:@"清除缓存 (已使用%.2f MB)", cacheSize];
        cell.textLabel.text = title01;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXLSettingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.settingItem.operation) {
        cell.settingItem.operation();
    } else if ([cell.settingItem isKindOfClass:[HXLSettingArrowItem class]]) {
        
        HXLSettingArrowItem *item = (HXLSettingArrowItem *)cell.settingItem;
        UIViewController *pushVC = nil;
        if (item.objectClass) { // 如果指定控制器
            pushVC  = [[item.objectClass alloc] init];
            
        } else { // 否则统一跳转一个控制, 暂时先;
            pushVC  = [[HXLArrowTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        }
        
        pushVC.title = item.title;
        [self.navigationController pushViewController:pushVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        // 清空缓存
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        
        [tableView reloadData];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
    sectionView.height = 40;
    sectionView.backgroundColor = GRAY_WHITE_COLOR;
    
    UILabel *label =[[UILabel alloc] init];
    label.font = FONT_14;
    label.text = (section == 0) ? [self.groupBaseArray[0] headerTitle] : [self.groupBaseArray[1] headerTitle];
    [label sizeToFit];
    
    label.x = 3 * DIY;
    label.y = 0;
    label.height = sectionView.height;
    [sectionView addSubview:label];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

@end

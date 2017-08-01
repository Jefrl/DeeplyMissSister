//
//  HXLNotificationTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/31.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLNotificationTableViewController.h"
#import "HXLArrowTableViewController.h"

#import "HXLSettingGroupItem.h"
#import "HXLSettingSwitchItem.h"
#import "HXLSettingArrowItem.h"

@interface HXLNotificationTableViewController ()
/** itemArrayOne */
@property (nonatomic, readwrite, strong) NSArray *itemArrayOne;
/** groupArray */
@property (nonatomic, readwrite, strong) NSArray *groupArray;

@end

@implementation HXLNotificationTableViewController
#pragma mark - 懒加载
- (NSArray *)itemArrayOne
{
    if (!_itemArrayOne) {
        
        HXLSettingArrowItem *item01 = [HXLSettingArrowItem itemWithTitle:@"帖子被评论" icon:nil];
        item01.objectClass = [HXLArrowTableViewController class];
        
        HXLSettingArrowItem *item02 = [HXLSettingArrowItem itemWithTitle:@"评论被回复" icon:nil];
        HXLArrowTableViewController *arrowTVC = [[HXLArrowTableViewController alloc] init];
        arrowTVC.title = item02.title;
        
        HXL_WEAKSELF;
        [item02 setOperation:^{
            HXL_STRONGSELF;
            
            [strongSelf.navigationController pushViewController:arrowTVC animated:YES];
        }];
        
        HXLSettingSwitchItem *item03 = [HXLSettingSwitchItem itemWithTitle:@"评论被顶" icon:nil];
        HXLSettingSwitchItem *item04 = [HXLSettingSwitchItem itemWithTitle:@"新增粉丝" icon:nil];
        HXLSettingSwitchItem *item05 = [HXLSettingSwitchItem itemWithTitle:@"好友动态" icon:nil];
        HXLSettingSwitchItem *item06 = [HXLSettingSwitchItem itemWithTitle:@"私信通知" icon:nil];
        NSArray *array = @[item01, item02, item03, item04, item05, item06];
        _itemArrayOne = array;
    }
    return _itemArrayOne;
}

- (NSArray *)groupArray
{
    if (!_groupArray) {
        
        HXLSettingGroupItem *groupItem01 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayOne];
        NSArray *array = @[groupItem01];
        _groupArray = array;
    }
    return _groupArray;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 給基类传递合理值
    self.groupBaseArray = self.groupArray;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BROWN_COLOR;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{ // 顶部留白问题, 不能设置0;
    return 0.1;
}


@end

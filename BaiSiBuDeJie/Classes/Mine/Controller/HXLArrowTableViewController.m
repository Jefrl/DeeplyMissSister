//
//  HXLArrowTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/31.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLArrowTableViewController.h"

#import "HXLSettingGroupItem.h"
#import "HXLSettingSwitchItem.h"
#import "HXLSettingArrowItem.h"

@interface HXLArrowTableViewController ()
/** itemArrayOne */
@property (nonatomic, readwrite, strong) NSArray *itemArrayOne;
/** itemArrayTwo */
@property (nonatomic, readwrite, strong) NSArray *itemArrayTwo;
/** itemArrayThree */
@property (nonatomic, readwrite, strong) NSArray *itemArrayThree;
/** groupArray */
@property (nonatomic, readwrite, strong) NSArray *groupArray;

@end

@implementation HXLArrowTableViewController
#pragma mark - 懒加载
- (NSArray *)itemArrayOne
{
    if (!_itemArrayOne) {
        // 第0组
        HXLSettingSwitchItem *item01 = [HXLSettingSwitchItem itemWithTitle:@"关注比赛" icon:nil];
        _itemArrayOne = @[item01];
    }
    return _itemArrayOne;
}

- (NSArray *)itemArrayTwo
{
    if (!_itemArrayTwo) {
        // 第1组
        HXLSettingBaseItem *item01 = [HXLSettingBaseItem itemWithTitle:@"起始时间" detailTitle:@"00 : 00" icon:nil];
        _itemArrayTwo = @[item01];
    }
    return _itemArrayTwo;
}

- (NSArray *)itemArrayThree
{
    HXLSettingBaseItem *item01 = [HXLSettingBaseItem itemWithTitle:@"结束时间" detailTitle:@"23 : 59" icon:nil];
    
    HXL_WEAKSELF;
    [item01 setOperationIndexPath:^(NSIndexPath *indexPath){
        HXL_STRONGSELF;
        // 在iOS7以后只要把TextFiled添加到cell 上就能实现自动计算高度,自动调整cell的位置
        UITableViewCell *cell = [strongSelf.tableView cellForRowAtIndexPath:indexPath];
        UITextField *textFiled = [[UITextField alloc] init];
        [textFiled becomeFirstResponder];
        [cell addSubview:textFiled];
    }];
    
    _itemArrayThree = @[item01];
    
    return _itemArrayThree;
}

- (NSArray *)groupArray
{
    if (!_groupArray) {
        
        HXLSettingGroupItem *groupItem01 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayOne];

        HXLSettingGroupItem *groupItem02 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayTwo];
        
        HXLSettingGroupItem *groupItem03 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        HXLSettingGroupItem *groupItem04 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        HXLSettingGroupItem *groupItem05 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        HXLSettingGroupItem *groupItem06 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        HXLSettingGroupItem *groupItem07 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        NSArray *array = @[groupItem01, groupItem02, groupItem03, groupItem04, groupItem05, groupItem06, groupItem07];
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
    self.tableView.rowHeight = 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{ // 顶部留白问题, 不能设置0;
    return 60;
}

// 当滑动的时候退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end

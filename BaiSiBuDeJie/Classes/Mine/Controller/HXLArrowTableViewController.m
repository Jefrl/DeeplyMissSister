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

//- (NSArray *)itemArrayTwo
//{
//    if (!_itemArrayTwo) {
//        // 第1组
//        HXLSettingArrowItem *item01 = [HXLSettingArrowItem itemWithTitle:@"起始时间" icon:nil];
//        item01.detailTitle = @"00 : 00";
//        _itemArrayTwo = @[item01];
//    }
//    return _itemArrayTwo;
//}

- (NSArray *)itemArrayThree
{
    //    // 第2组
    if (!_itemArrayThree) {
        HXLSettingBaseItem *item02 = [HXLSettingBaseItem itemWithTitle:@"结束时间" icon:nil];
        item02.detailTitle = @"23 : 59";
        
        HXL_WEAKSELF;
        [item02 setOperationIndexPath:^(NSIndexPath *indexPath){
            HXL_STRONGSELF;
            // 在iOS7以后只要把TextFiled添加到cell 上就能实现自动计算高度,自动调整cell的位置
            UITableViewCell *cell = [strongSelf.tableView cellForRowAtIndexPath:indexPath];
            UITextField *textFiled = [[UITextField alloc] init];
            [textFiled becomeFirstResponder];
            textFiled.backgroundColor = BLUE_COLOR;
            [cell addSubview:textFiled];
        }];
        
        _itemArrayThree = @[item02];
    }
    return _itemArrayThree;
}

- (NSArray *)groupArray
{
    if (!_groupArray) {
        
        HXLSettingGroupItem *groupItem01 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayOne];

#warning 存在一个 bug 奇怪;
//        HXLSettingGroupItem *groupItem02 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayTwo];
        
        HXLSettingGroupItem *groupItem03 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        HXLSettingGroupItem *groupItem04 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
        HXLSettingGroupItem *groupItem05 = [HXLSettingGroupItem groupWithHeaderTitle:nil footerTitle:nil andSettingItemArray:self.itemArrayThree];
        
//        NSLog(@"%@---%@----%@----%@---%@", groupItem01, groupItem02, groupItem03, groupItem04, groupItem05);
//        NSLog(@"%@---%@----%@----%@---%@", groupItem01.settingItemArray, groupItem02.settingItemArray, groupItem03.settingItemArray, groupItem04.settingItemArray, groupItem05.settingItemArray);
        
        NSArray *array = @[groupItem01, groupItem03, groupItem04, groupItem05];
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
    return 80;
}

// 当滑动的时候退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end

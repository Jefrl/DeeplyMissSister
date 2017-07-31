//
//  HXLSettingTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/29.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSettingTableViewController.h"
#import "HXLSettingTableViewCell.h"
#import "HXLNotificationTableViewController.h"
#import "HXLHelpTableViewController.h"
#import "HXLArrowTableViewController.h"

#import "HXLSettingGroupItem.h"
#import "HXLSettingBaseItem.h"
#import "HXLSettingArrowItem.h"
#import "HXLSettingSwitchItem.h"
#import "HXLSettingSegmentedItem.h"

#import "SDImageCache.h"
#import "MJExtension.h"

@interface HXLSettingTableViewController ()
/** groupArray */
@property (nonatomic, readwrite, strong) NSArray *groupArray;

/** itemArrayOne */
@property (nonatomic, readwrite, strong) NSArray *itemArrayOne;

/** itemArrayTwo */
@property (nonatomic, readwrite, strong) NSArray *itemArrayTwo;

@end

@implementation HXLSettingTableViewController
#pragma mark - 懒加载
- (NSArray *)itemArrayOne
{
    if (!_itemArrayOne) {
        HXLSettingSegmentedItem *item01 = [HXLSettingSegmentedItem itemWithTitle:@"字体大小" icon:nil];
        HXLSettingArrowItem *item02 = [HXLSettingArrowItem itemWithTitle:@"通知设置" icon:nil];
        item02.title = @"通知设置";
        
        // 具备跳转功能 --- block 方式
        HXLNotificationTableViewController *notiTVC = [[HXLNotificationTableViewController alloc] init];
        notiTVC.title = item02.title;
        
        HXL_WEAKSELF;
        item02.operation = ^{
            HXL_STRONGSELF;
            [strongSelf.navigationController pushViewController:notiTVC animated:YES];
        };
        
        HXLSettingSwitchItem *item03 = [HXLSettingSwitchItem itemWithTitle:@"应用内私信提醒" icon:nil];
        item03.open = NO;
        
        NSArray *array = @[item01, item02, item03];
        _itemArrayOne = array;
    }
    return _itemArrayOne;
}

- (NSArray *)itemArrayTwo
{
    if (!_itemArrayTwo) {
        
        HXLSettingArrowItem *item01 = [HXLSettingArrowItem itemWithTitle:nil icon:nil];
        HXLSettingArrowItem *item02 = [HXLSettingArrowItem itemWithTitle:@"推荐给朋友" icon:nil];
        HXLSettingArrowItem *item03 = [HXLSettingArrowItem itemWithTitle:@"帮助" icon:nil];
        // 具备点击跳转方式二 --- 绑定类属性;
        item03.objectClass = [HXLHelpTableViewController class];
        
        NSString *title04 = [NSString stringWithFormat:@"当前版本: %@", CURRENT_VERSION];
        HXLSettingBaseItem *item04 = [HXLSettingBaseItem itemWithTitle:title04 icon:nil];
        HXLSettingArrowItem *item05 = [HXLSettingArrowItem itemWithTitle:@"关于我们" icon:nil];
        HXLSettingArrowItem *item06 = [HXLSettingArrowItem itemWithTitle:@"隐私政策" icon:nil];
        HXLSettingArrowItem *item07 = [HXLSettingArrowItem itemWithTitle:@"打分支持不得姐" icon:nil];
        NSArray *array = @[item01, item02, item03, item04, item05, item06, item07];
        _itemArrayTwo = array;
    }
    return _itemArrayTwo;
}

- (NSArray *)groupArray
{
    if (!_groupArray) {
        
        HXLSettingGroupItem *groupItem01 = [HXLSettingGroupItem groupWithHeaderTitle:@"功能设置" footerTitle:nil andSettingItemArray:self.itemArrayOne];
        HXLSettingGroupItem *groupItem02 = [HXLSettingGroupItem groupWithHeaderTitle:@"其他" footerTitle:nil andSettingItemArray:self.itemArrayTwo];
        NSArray *array = @[groupItem01, groupItem02];
        
        _groupArray = array;
    }
    return _groupArray;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUniformStyle];
    // 給基类传递合理值
    self.groupBaseArray = self.groupArray;
}

- (void)setupUniformStyle
{
    self.title = @"设置";
    self.tableView.backgroundColor = GRAY_WHITE_COLOR;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    self.tableView.rowHeight = 40;
    
    UIView *footView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
    footView.height = 50;
    footView.backgroundColor = GRAY_WHITE_COLOR;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = FONT_16;
    button.backgroundColor = WHITE_COLOR;
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [button setTitleColor:RED_COLOR forState:UIControlStateNormal];
    [button addTarget:self action:@selector(quitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = footView.bounds;
    button.y = 10;
    [footView addSubview:button];
    
    self.tableView.tableFooterView = footView;
}

#pragma mark - 响应的方法区域
- (void)quitBtnClick:(UIButton *)sender
{
    [sender setBackgroundColor:GRAY_WHITE_COLOR];
    [UIView animateWithDuration:0.3 animations:^{
        [sender setBackgroundColor:WHITE_COLOR];
    }];
}


@end


/*

if (indexPath.section == 0) {
    NSInteger row = indexPath.row;
    if (row == 0) {
        
        cell.textLabel.text = @"字体大小";
    } else if (row == 1) {
        cell.accessoryType = UIAccessibilityTraitButton;
        cell.textLabel.text = @"通知设置";
    } else if (row == 2) {
        
        cell.textLabel.text = @"应用内私心提醒";
        
    }
} else {
    NSInteger row = indexPath.row;
    if (row == 0) {
        CGFloat cacheSize = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
        NSLog(@"%.2f", cacheSize);
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存 (已使用%.2f MB)", cacheSize];
        cell.accessoryType = UIAccessibilityTraitButton;
    } else if (row == 1) {
        cell.textLabel.text = @"推荐给朋友";
        cell.accessoryType = UIAccessibilityTraitButton;
    } else if (row == 2) {
        cell.textLabel.text = @"帮助";
        cell.accessoryType = UIAccessibilityTraitButton;
    } else if (row == 3) {
        NSString *currentVersion = [NSString stringWithFormat:@"当前版本: %@", CURRENT_VERSION];
        cell.textLabel.text = currentVersion;
        
    } else if (row == 4) {
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UIAccessibilityTraitButton;
    } else if (row == 5) {
        cell.textLabel.text = @"隐私政策";
        cell.accessoryType = UIAccessibilityTraitButton;
    } else if (row == 6) {
        cell.textLabel.text = @"打分支持不得姐";
        cell.accessoryType = UIAccessibilityTraitButton;
    }
    
}


 */

/*
- (void)getSize2
{
    // 图片缓存
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    //    XMGLog(@"%zd %@", size, NSTemporaryDirectory());
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 文件夹
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 获得文件夹内部的所有内容
    //    NSArray *contents = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    NSArray *subpaths = [manager subpathsAtPath:cachePath];
    NSLog(@"%@", subpaths);
}

- (void)getSize
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachePath];
    NSInteger totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filepath = [cachePath stringByAppendingPathComponent:fileName];
        
        //        BOOL dir = NO;
        // 判断文件的类型：文件\文件夹
        //        [manager fileExistsAtPath:filepath isDirectory:&dir];
        //        if (dir) continue;
        
        NSDictionary *attrs = [manager attributesOfItemAtPath:filepath error:nil];
        
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        totalSize += [attrs[NSFileSize] integerValue];
    }
    
    NSLog(@"%zd", totalSize);
}

*/

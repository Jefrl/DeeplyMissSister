//
//  HXLAllTableVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLAllTableVC.h"

@interface HXLAllTableVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HXLAllTableVC
// 重用标识;
NSString * const tableView_reuseID = @"allCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 由于滚动的原因, tableView 系统默认低于状态栏, 高度也减了状态栏的高度;
    self.view.height += self.view.y;
    self.view.y = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT + HeadlineView_height, 0, TABBAR_HEIGHT, 0);
    // scrollIndicatorInsets 的设置;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableView_reuseID];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSLog(@"%@", NSStringFromCGRect(SCREEN_BOUNDS));
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView_reuseID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableView_reuseID];
    }
    
    cell.detailTextLabel.text = @"123";
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行", indexPath.row];
    return cell;
}


@end

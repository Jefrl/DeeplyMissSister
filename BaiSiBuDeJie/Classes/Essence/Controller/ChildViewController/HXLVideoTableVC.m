//
//  HXLVideoTableVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLVideoTableVC.h"
#import "HXLVideoTableViewCell.h"

@interface HXLVideoTableVC ()

@end

@implementation HXLVideoTableVC

// 重用标识;
NSString * const video_reuseID = @"videoCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // 调整上下内边距;
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT + HeadlineView_height, 0, TABBAR_HEIGHT, 0);
    self.tableView.height += self.tableView.y;
    self.tableView.y = 0;
    
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    
    // tableView 的注册,代理以及数据源设置;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLVideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:video_reuseID];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:video_reuseID];
    
    cell.detailTextLabel.text = @"123";
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行", indexPath.row];
    return cell;
}
@end

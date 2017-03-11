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
NSString * const tableView_reuseID = @"tableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT + HeadlineView_height, 0, TABBAR_HEIGHT, 0);
    self.tableView.height += self.tableView.y;
    self.tableView.y = 0;
    
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableView_reuseID];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

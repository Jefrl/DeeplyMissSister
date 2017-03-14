//
//  HXLPunTableVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPunTableVC.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "HXLSessionManager.h"


@interface HXLPunTableVC ()
/** HXLSessionManager 对象 */
@property (nonatomic, strong) HXLSessionManager *sessionManager;
/** itemArray */
@property (nonatomic, strong) NSArray *itemArray;
/** responseDict */
@property (nonatomic, strong) NSDictionary *responseDict;

@end

@implementation HXLPunTableVC

NSString *const pubicUrl = @"http://api.budejie.com/api/api_open.php";
singtonImplement(HXLPunTableVC)
// 重用标识;
NSString * const pun_reuseID = @"punCell";

- (HXLSessionManager *)manager {
    if (!_sessionManager) {
        _sessionManager = [[HXLSessionManager alloc] init];
        
        NSMutableSet *setM = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        _sessionManager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 由于滚动的原因, tableView 系统默认低于状态栏, 高度也减了状态栏的高度;
    self.view.height += self.view.y;
    self.view.y = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT + HeadlineView_height, 0, TABBAR_HEIGHT, 0);
    // scrollIndicatorInsets 的设置;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSLog(@"%@", NSStringFromCGRect(SCREEN_BOUNDS));
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"type"] = @"41";
    params[@"c"] = @"data";
    
    [self.sessionManager request:RequestTypeGet urlStr:pubicUrl parameters:params resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"%@", self.responseDict);
        self.responseDict = responseObject;
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pun_reuseID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:pun_reuseID];
    }

    NSLog(@"%@", _responseDict);
    [_responseDict writeToFile:@"/Users/Jefrl/Desktop/pun1.plist" atomically:YES];
    NSDictionary *dict = _responseDict[@"list"][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dict[@"profile_image"]];
    cell.detailTextLabel.text = dict[@"created_at"];
    cell.textLabel.text = @"name";
    return cell;
}


@end

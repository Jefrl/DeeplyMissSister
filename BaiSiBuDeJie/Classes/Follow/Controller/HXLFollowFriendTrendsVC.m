//
//  HXLFollowFriendTrendsVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLFollowFriendTrendsVC.h"

#import "MJRefresh.h"
#import "MJExtension.h"
#import "HXLSessionManager.h"

@interface HXLFollowFriendTrendsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
/** sessionManager */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;

@end

@implementation HXLFollowFriendTrendsVC
- (HXLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        HXLSessionManager *mg = [HXLSessionManager manager];
        _sessionManager = mg;
    }
    
    return _sessionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    
    self.leftTableView.estimatedRowHeight = 44;
    self.rightTableView.estimatedRowHeight = 44;
    
    [self setupRefresh];
    
}

#pragma mark - 网络数据加载
- (void)setupRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRecommendData)];
    self.rightTableView.mj_header = header;
    [self.rightTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRecommendData)];
    self.leftTableView.mj_footer = footer;
}

- (void)loadNewRecommendData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"";
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)loadMoreRecommendData
{
    
}

#pragma mark - TableView Delegate or DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return 7;
    }
    
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const followReuseID = @"followLeftCell";
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followReuseID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:followReuseID];
        cell.backgroundColor = GRAY_COLOR;
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:followReuseID];
        cell.backgroundColor = BROWN_COLOR;
    }
    return cell;
}


@end

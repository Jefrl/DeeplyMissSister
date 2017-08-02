//
//  HXLFollowFriendTrendsVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLFollowFriendTrendsVC.h"

#import "HXLFollowCategoryTableViewCell.h"
#import "HXLFollowUserTableViewCell.h"
#import "HXLPersonDetailViewController.h"

#import "HXLFollowCategoryItem.h"
#import "HXLFollowUserItem.h"

#import "MJRefresh.h"
#import "MJExtension.h"
#import "HXLSessionManager.h"
#import "SVProgressHUD.h"

@interface HXLFollowFriendTrendsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
/** 推荐关注的分类数组 */
@property (nonatomic, readwrite, strong) NSArray *categoryArray;
/** 推荐关注的用户数组 */
@property (nonatomic, readwrite, strong) NSArray *userArray;
/** sessionManager */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;
/** 左侧选中的cell 的 indexPath */
@property (nonatomic, readwrite, strong) NSIndexPath *seletedIndexPath;
/** page */
@property (nonatomic, readwrite, assign) NSInteger page;
/** 请求参数 */
@property (nonatomic, readwrite, strong) NSMutableDictionary *parameter;

@end

@implementation HXLFollowFriendTrendsVC

#pragma mark - Lazy load
- (NSIndexPath *)seletedIndexPath
{
    if (!_seletedIndexPath) {
        NSIndexPath *indexPath = [[NSIndexPath alloc] init];
        _seletedIndexPath = indexPath;
    }
    return _seletedIndexPath;
}

- (NSArray *)userArray
{
    if (!_userArray) {
        NSArray *arr = [NSArray array];
        _userArray = arr;
    }
    return _userArray;
}

- (NSArray *)categoryArray
{
    if (!_categoryArray) {
        NSArray *arr = [NSArray array];
        _categoryArray = arr;
    }
    return _categoryArray;
}

- (HXLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        HXLSessionManager *mg = [HXLSessionManager manager];
        _sessionManager = mg;
    }
    return _sessionManager;
}

#pragma mark - 初始化 Initial setting
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化的基础设置
    [self setupUniformStyle];
    // 左侧分类列表 网络数据加载
    [self loadCategoryData];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    [self.sessionManager.operationQueue cancelAllOperations];
}

// 初始化的基础设置
- (void)setupUniformStyle
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    
    self.title = @"推荐关注";
    // 代理
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    // 行高与滚动
    self.leftTableView.rowHeight = 50;
    self.rightTableView.rowHeight = 80;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, 0, 0);
    // 背景颜色与分割线
    self.leftTableView.backgroundColor = GRAY_PUBLIC_COLOR;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.backgroundColor = GRAY_PUBLIC_COLOR;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册 cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLFollowCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:followCategoryReuseID];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLFollowUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:followUserReuseID];
}

#pragma mark - 网络数据加载
// 左侧列表初始化
- (void)loadCategoryData
{
    
    // 提示正在加载框
    [SVProgressHUD showWithStatus:@"主人, 小的正在加载"];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"category";
    parameter[@"c"] = @"subscribe";
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"Follow", @"category");
        
        [SVProgressHUD showSuccessWithStatus:@"主人, O(∩_∩)O 哈哈~加载成功"];
        [SVProgressHUD dismissWithDelay:0.5];
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"responseObject, 不是字典, 无数据");
            [self loadDataFailure:self.rightTableView.mj_header];
            return ;
        }
        
        self.categoryArray = [HXLFollowCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.leftTableView reloadData];
        // 初次选中 左侧 第0行
        self.seletedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.leftTableView selectRowAtIndexPath:_seletedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 启动右侧加载, 下拉更新数据
        [self setupRefresh];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [self loadDataFailure:self.rightTableView.mj_header];
        
        Error(error)
    }];
}

// 右侧上下拉控件初始化
- (void)setupRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRecommendData)];
    self.rightTableView.mj_header = header;
    [self.rightTableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRecommendData)];
    self.rightTableView.mj_footer = footer;
    self.rightTableView.mj_footer.hidden = YES;
}

// 下拉更新
- (void)loadNewRecommendData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"list";
    parameter[@"c"] = @"subscribe";
    HXLFollowCategoryItem *item = self.categoryArray[_seletedIndexPath.row];
    parameter[@"category_id"] = @(item.ID);
    self.parameter = parameter;
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"Follow", @"user");
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"responseObject, 不是字典, 无数据");
            [self loadDataFailure:self.rightTableView.mj_header];
            return ;
        }
        
        // 不是最后一次请求, 慢网速快速切换上下刷新, 或快速切换别的 section 刷新时;
        if (self.parameter != parameter) return;
        
        self.userArray = [HXLFollowUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.rightTableView reloadData];
        [self.rightTableView.mj_header endRefreshing];
        // 恢复默认页码 1
        self.page = 1;
        
        // 是否所有数据加载完
        [self allDataDidLoaded:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        Error(error);
        [self loadDataFailure:self.rightTableView.mj_header];
    }];
}

// 上拉更多
- (void)loadMoreRecommendData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"list";
    parameter[@"c"] = @"subscribe";
    HXLFollowCategoryItem *item = self.categoryArray[_seletedIndexPath.row];
    parameter[@"category_id"] = @(item.ID);
    parameter[@"page"] = @(self.page + 1);
    self.parameter = parameter;
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"Follow", @"user");
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"responseObject, 不是字典, 无数据");
           [self loadDataFailure:self.rightTableView.mj_footer];
            return ;
        }
        
        // 不是最后一次请求
        if (self.parameter != parameter) return;
        
        NSMutableArray *arrayM = [HXLFollowUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.userArray.count)];
        [arrayM insertObjects:self.userArray atIndexes:indexSet];
        
        self.userArray = arrayM;
        
        [self.rightTableView reloadData];
        [self.rightTableView.mj_footer endRefreshing];
        // 页码加 1;
        self.page ++;
        // 是否所有数据加载完
        [self allDataDidLoaded:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
        [self loadDataFailure:self.rightTableView.mj_footer];
        Error(error);
    }];
    
}

#pragma mark - 抽取方法 from 网络数据加载中
- (void)loadDataFailure:(MJRefreshComponent *)refreshView
{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    [refreshView endRefreshing];
    [SVProgressHUD dismissWithDelay:0.5];
}

- (void)allDataDidLoaded:(NSDictionary *)responseObject
{
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.rightTableView.mj_footer.hidden = (self.userArray.count == 0);
    // 是否到了最大页码
    NSInteger total = [responseObject[@"total"] integerValue];
    if (total <= self.userArray.count) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - TableView Delegate or DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.categoryArray.count;
    }
    
    // 上拉, 刷新 tableView 时, 恢复下拉控件;
    self.rightTableView.mj_footer.hidden = (self.userArray.count == 0);
    return self.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        HXLFollowCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followCategoryReuseID];
        cell.contentView.backgroundColor = GRAY_COLOR;
        cell.categoryItem = self.categoryArray[indexPath.row];
        
        return cell;
    }
    
    HXLFollowUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followUserReuseID];
    
    cell.backgroundColor = WHITE_COLOR;
    cell.userItem = self.userArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果点击了新的左侧分类, 先停止控件刷新
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    if (tableView == self.leftTableView) {
        // 如果曾今加载过, 点击左侧时, 不再重复加载右侧, 除非用户自己主动下拉
        if (self.userArray.count) {
            [self.rightTableView reloadData];
        } else {
            // 不让界面的残留数据影响视觉, 应该先立即执行一次刷新;
            [self.rightTableView reloadData];
            // 刷新右侧数据
            [self.rightTableView.mj_header beginRefreshing];
        }
        // 记录选中的左侧 cell 的索引, 以便更新参数
        self.seletedIndexPath = indexPath;
    }
    if (tableView == self.rightTableView) {
        // 跳转对应的界面
        HXLPersonDetailViewController *detailVC = [[HXLPersonDetailViewController alloc] init];
        detailVC.userItem = self.userArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }

}

@end

//
//  HXLRecommendTagTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/20.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLRecommendTagTableViewController.h"
#import "HXLRecommentTagTableViewCell.h"
#import "HXLRecommentTagItem.h"

#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface HXLRecommendTagTableViewController ()
/** 推荐标签数组 */
@property (nonatomic, readwrite, strong) NSArray *recommentTagArray;
/** sessionManager */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;
/** 请求参数 */
@property (nonatomic, readwrite, strong) NSMutableDictionary *parameter;
@end

@implementation HXLRecommendTagTableViewController
- (NSArray *)recommentTagArray
{
    if (!_recommentTagArray) {
        NSArray *arr = [NSArray array];
        _recommentTagArray = arr;
    }
    return _recommentTagArray;
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
    [self setupRefresh];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

// 初始化的基础设置
- (void)setupUniformStyle
{
    self.title = @"推荐标签";
    // 行高与滚动
    self.tableView.rowHeight = 80;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, 0, 0);
    // 背景颜色与分割线
    self.tableView.backgroundColor = GRAY_PUBLIC_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLRecommentTagTableViewCell class]) bundle:nil] forCellReuseIdentifier:recommentTagReuseID];

}

#pragma mark - 网络数据加载

// 右侧上下拉控件初始化
- (void)setupRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRecommendTagData)];
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}
    

// 下拉更新
- (void)loadNewRecommendTagData
{
    // 提示正在加载框
    [SVProgressHUD showWithStatus:@"主人, 小的正在加载"];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"tag_recommend";
    parameter[@"action"] = @"sub";
    parameter[@"c"] = @"topic";
    self.parameter = parameter;
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"Recomment", @"-tag");
        
        // 不是最后一次请求, 慢网速快速切换上下刷新, 或快速切换别的 section 刷新时;
        if (self.parameter != parameter) return;
        [SVProgressHUD showSuccessWithStatus:@"主人, O(∩_∩)O 哈哈~加载成功"];
        [SVProgressHUD dismissWithDelay:0.5];
        
        self.recommentTagArray = [HXLRecommentTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        Error(error);
        [SVProgressHUD showErrorWithStatus:@"主人~~~~(>_<)~~~~, 加载失败了"];
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - TableView Delegate or DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 上拉, 刷新 tableView 时, 恢复下拉控件;
    self.tableView.mj_footer.hidden = (self.recommentTagArray.count == 0);
    return self.recommentTagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXLRecommentTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommentTagReuseID];
    
    cell.recommentTagItem = self.recommentTagArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转对应的界面
//    HXLPersonDetailViewController *detailVC = [[HXLPersonDetailViewController alloc] init];
//    detailVC.userItem = self.userArray[indexPath.row];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end

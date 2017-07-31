//
//  HXLEssenceBaseWithChildTVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceBaseWithChildTVC.h"
#import "HXLEssenceViewController.h"

#import "HXLPunTableVC.h"
#import "HXLCommentViewController.h"
#import "HXLPunTableViewCell.h"
#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"

#import "HXLSessionManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"



@interface HXLEssenceBaseWithChildTVC ()

/** HXLSessionManager 对象 */
@property (nonatomic, strong) HXLSessionManager *sessionManager;
/** 帖子模型数组 */
@property (strong, nonatomic) NSMutableArray *itemArrayM;
/** 帖子最热评模型数组(只有一组) */
@property (nonatomic, strong) NSArray *hottestArray;
/** 帖子所有热评模型数组(有多组) */
@property (nonatomic, strong) NSMutableArray *allHots;
/** cell 保存? */
@property (nonatomic, strong) HXLPunTableViewCell *cell;
/** dict */
@property (nonatomic, strong) NSDictionary *dict;
/** containBottomViewHight */
@property (nonatomic, assign) CGFloat containBottomViewHight;


/** params 请求数据的参数 */
@property (nonatomic, readwrite, strong) NSMutableDictionary *params;
/** 请求下页数据, 要增加的参数 maxtimes */
@property (nonatomic, readwrite, strong) NSString *maxtime;
/** 当期页码数 */
@property (nonatomic, readwrite,  assign) NSInteger page;
/** 上次选中的tabar索引(或者控制器) */
@property (nonatomic, assign) NSInteger lastSelectedIndex;
/** tabBarOb */
@property (nonatomic, readwrite, strong) NSNotificationCenter *tabBarOb;

/** essenceOrLastestA */
@property (nonatomic, readwrite, strong) NSString *essenceOrLastestA;


@end

@implementation HXLEssenceBaseWithChildTVC

#pragma mark - Lazy load
- (NSString *)essenceOrLastestA
{
    _essenceOrLastestA = [self.parentViewController isMemberOfClass:[HXLEssenceViewController class]] ? @"list" : @"newlist";
    
    return _essenceOrLastestA;
}

- (NSMutableArray *)hots
{
    if (!_allHots) {
        NSMutableArray *arrM = [NSMutableArray array];
        _allHots = arrM;
    }
    return _allHots;
}

- (NSMutableArray *)itemArrayM
{
    if (!_itemArrayM) {
        _itemArrayM = [NSMutableArray array];
    }
    return _itemArrayM;
}

- (NSArray *)hottestArray
{
    if (!_hottestArray) {
        _hottestArray = [NSArray array];
    }
    return  _hottestArray;
}

// 网络请求者
- (HXLSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [HXLSessionManager manager];
        
        NSMutableSet *setM = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"application/json"];
        [setM addObject:@"text/json"];
        [setM addObject:@"text/javascript"];
        [setM addObject:@"text/html"];

        _sessionManager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionManager;
}

#pragma mark - Init zone
- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一风格;
    [self setupUniformStyle];
    // 初始化网络数据
    [self setupRefresh];
    // 注册通知观察者
    [self observeNotiForTabbar];
}

#pragma mark - function zone
- (void)observeNotiForTabbar
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotiTabBarbtn:) name:HXLTabBarDidSelectNotification object:nil];
}

- (void)getNotiTabBarbtn:(NSNotification *)noti
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealloc
{ // 由于有看大图的 modal 视图, 不能用 viewWillDisappear 方法
    NSLog(@"");
    // 移除通知观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUniformStyle {
    
    self.tableView.backgroundColor = RGBColor(255, 255, 255, 1);
    // 由于滚动的原因, tableView 系统默认低于状态栏, 高度也减了状态栏的高度;
    self.view.height += self.view.y;
    self.view.y = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT + HeadlineView_height, 0, TABBAR_HEIGHT, 0);
    // scrollIndicatorInsets 的设置;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.estimatedRowHeight = 44;
    // 注册 xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLPunTableViewCell class]) bundle:nil] forCellReuseIdentifier:pun_reuseID];
}

#pragma mark - 设置上拉刷新, 下拉加载

/**
 初始化 Refresh
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.hidden = YES;
}

/**
 下拉更新
 */
- (void)loadNewTopics {
    // 当用户在上拉加载过程中, 立马又下拉更新, 这时先停止掉上拉加载;
    [self.tableView.mj_footer endRefreshing];
    
    // 请求不同类型贴子的参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 由于这个是基类, 新帖也是它的子类, 那么一进入的初次刷新, 需要评判在哪个页面
    params[@"a"] = self.essenceOrLastestA;
    // 将数字包装成对象, AFN内部会处理;
    params[@"type"] = @(self.type);
    params[@"c"] = @"data";
    params[@"per"] = @(loadCount); // 自定义加载多少条
    self.params = params;
    
    // 请求发出
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
       
        WriteToPlist(responseObject, @"pun", @(self.type))
        
        self.maxtime =  responseObject[@"info"][@"maxtime"];
        if (self.params != params) { // 判断是否 在加载过程中, 用户将对应的父控制器(精华控制器) 切换到了 最新控制器!
            return ; // 停止加载
        }
        
        // 字典数组转 模型数组
        self.itemArrayM = [HXLEssenceItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 获得新数据, 刷新界面
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        // 页码清 0
        self.page = 0;
        
        [self refreshTwice];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        if (error) {
            NSLog(@"%@", error);
        }
    }];
    
}

// 连续刷新两次, 当第一次打开应用程序时;
- (void)refreshTwice
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header beginRefreshing];
        });
        
    });
}

/**
 上拉加载
 */
- (void)loadMoreTopics {
    
    [self.tableView.mj_header endRefreshing];
    
    // 请求不同类型贴子的参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.essenceOrLastestA;
    // 将数字包装成对象, AFN内部会处理;
    params[@"type"] = @(self.type);
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"page"] = @(self.page + 1);
    
    // 及时记录
    self.params = params;
    
    // 请求发出
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"pun", @(self.type))
        self.maxtime =  responseObject[@"info"][@"maxtime"];
        
        if (self.params != params) { // 判断是否 在加载过程中, 用户将精华控制器 切换到了 最新控制器!
            return ; // 停止加载
        }
        
        // 字典数组转 模型数组
        NSArray *array = [HXLEssenceItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.itemArrayM addObjectsFromArray:array];
        
        // 获得新数据, 刷新界面
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView. mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        if (error) {
            NSLog(@"%@", error);
        }
    }];
    
}

#pragma mark - TableView Delegate or DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.itemArrayM.count == 0);
    return self.itemArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXLPunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pun_reuseID forIndexPath:indexPath];
    
    HXLEssenceItem *item = self.itemArrayM[indexPath.row];
    cell.punCellItem = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXLEssenceItem *item = _itemArrayM[indexPath.row];
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXLCommentViewController *commentVC = [[HXLCommentViewController alloc] init];
    HXLEssenceItem *item = self.itemArrayM[indexPath.row];
    commentVC.punCellItem = item;
    [self.navigationController pushViewController:commentVC animated:YES];
    // 调试的页面类型, 非页面内 tableViewCell 的类型;
    commentVC.collectionCellType = self.type;
    
}

@end

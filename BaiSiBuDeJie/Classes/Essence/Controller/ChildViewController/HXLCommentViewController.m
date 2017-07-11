//
//  HXLCommentViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/7.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLCommentViewController.h"
#import "HXLPunTableViewCell.h"
#import "HXLCommentTableViewCell.h"
#import "HXLCoverView.h"
#import "HXLPopMenu.h"
#import "HXLHeaderFooterView.h"

#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"


#import "HXLSessionManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"


@interface HXLCommentViewController ()<UITableViewDataSource, UITableViewDelegate, HXLPopMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTF;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
/** 网络会话管理者 */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;
/** 最新模型数组 */
@property (nonatomic, readwrite, strong) NSMutableArray *commentArray;
/** 最热模型数组 */
@property (nonatomic, readwrite, strong) NSArray *hotArray;
/** coverView */
@property (nonatomic, readwrite, strong) HXLCoverView *coverView;
/** popMenu */
@property (nonatomic, readwrite, strong) HXLPopMenu *popMenu;
/** duration */
@property (nonatomic, readwrite, assign) CGFloat duration;
/** page */
@property (nonatomic, readwrite, assign) NSInteger page;
/** responseObject */
@property (nonatomic, readwrite, strong) id responseObject;

@end

@implementation HXLCommentViewController
#pragma mark - Lazy settings zone
- (NSArray *)hotArray
{
    if (!_hotArray) {
        NSArray *hotArray = [NSArray array];
        _hotArray = hotArray;
    }
    return _hotArray;
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        NSMutableArray *commentArray = [NSMutableArray array];
        _commentArray = commentArray;
    }
    return _commentArray;
}
- (HXLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        HXLSessionManager *sessionManager = [HXLSessionManager manager];
        _sessionManager = sessionManager;
    }
    
    return _sessionManager;
}

#pragma mark - Initialization settings
- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一设置区域
    [self setupUniformStyle];
    // 网络加载
    [self setupRefresh];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

}

// 供所继承的导航控制器调用
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// 用代码实现 cell 的分割线起始位置 iOS8开始有变化
-(void)viewDidLayoutSubviews
{
    UIEdgeInsets separatorInset = UIEdgeInsetsMake(0, essenceMargin_x, 0, 0);
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:separatorInset];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:separatorInset];
    }
}

// 收回通知等操作
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 停止网络任务
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

#pragma mark - 优化抽取的功能方法大区域
- (void)setupUniformStyle
{
    // 基本设置 comment_nav_item_share_icon_click
    self.title = @"评论";
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, TABBAR_HEIGHT, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 搭建 tableView 的头部视图
    [self setupTableHeaderView];
    
    // 去掉 多余 cell 中的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 注册 cell;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:cmt_reuseID];
}

- (void)setupTableHeaderView
{
    HXLPunTableViewCell *cell = [HXLPunTableViewCell loadViewFormXib:0];
    cell.punCellItem = self.punCellItem;
    cell.height = self.punCellItem.height;
    // 头部视图的高度调整
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = WHITE_COLOR;
    [headerView addSubview:cell];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,  cell.height + essenceMargin_y);
    // 为了方便调整间距, 我们一般选择再包裹一层 View;
    UIView *header = [[UIView alloc] init];
    header.height = headerView.height + essenceMargin_y;
    header.backgroundColor = GRAY_PUBLIC_COLOR;
    [header addSubview:headerView];
    
    // 当把自定义的头部视图, 加入赋值给 tableView时, cell 所属的类中的 layoutsubViews 就会被调用, 这也是我们包裹 UIView 的原因
    self.tableView.tableHeaderView = header;
    
}

#pragma mark - 监听到键盘变化所执行的方法 keyboardWillChangeFrame
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 更改约束;
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat changeValue = SCREEN_HEIGHT - keyboardFrame.origin.y;
    self.bottomSpace.constant = changeValue;
    // 执行约束变化
    self.duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 刷新约束
    [UIView animateWithDuration:_duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    [self setupCoverView:CGRectMake(0, 0, SCREEN_WIDTH, self.bottomView.y)];
}

#pragma mark - 加蒙板跟弹收动画区域
- (void)setupCoverView:(CGRect)frame
{
    self.coverView = [[HXLCoverView alloc] initWithFrame:frame];
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTap)];
    [self.coverView addGestureRecognizer:tapGest];
    
    HXLPopMenu *popMenu = [HXLPopMenu showInCenter:self.coverView.center animateWithDuration:self.duration];
    self.popMenu = popMenu;
    
    // 定义 popMenBlock
    
    HXL_WEAKSELF;
    self.popMenu.popMenBlock = ^() {
        HXL_STRONGSELF;
        
        [strongSelf.popMenu hideInCenter:CGPointZero animateWithDuration:strongSelf.duration completion:^{
            [strongSelf.coverView removeFromSuperview];
        }];
        
        [strongSelf.view endEditing:YES];
    };
    
}

- (void)coverViewTap
{
    self.popMenu.popMenBlock();
}

#pragma mark - LoadData
#pragma mark - LoadData 抽取的方法
- (void)alldataDidLoadByPullup
{
    NSInteger total = [self.responseObject[@"total"] integerValue];
    if (self.commentArray.count >= total) {
        // 结束刷新状态
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = YES;
    } else {
        // 结束刷新状态
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)alldataDidLoadByPulldown
{
    NSInteger total = [self.responseObject[@"total"] integerValue];
    if (self.commentArray.count >= total) {
        // 结束刷新状态
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_header.hidden = YES;
    } else {
        // 结束刷新状态
        [self.tableView.mj_header endRefreshing];
    }
}


// 上下拉控件初始化
- (void)setupRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    // 初次刷新
    [header beginRefreshing];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
//    footer.hidden = YES;
    self.tableView.mj_footer = footer;
}

// 下拉更新
- (void)loadNewComment
{
//    [self.tableView.mj_footer endRefreshing];
    [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.punCellItem.ID;
    parameters[@"per"] = @(loadCount);
    parameters[@"hot"] = @1;
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"Comment", @(self.collectionCellType));
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) { // 如果没有数据;
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_header.hidden = YES;
            return ;
        }
        
        self.responseObject = responseObject;
        self.commentArray = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotArray = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        [self.tableView reloadData];
        // 恢复默认页码
        self.page = 1;
        // 判断
        [self alldataDidLoadByPulldown];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        
        if (error) {
            NSLog(@"%@", error);
        }
    
    }];
}

// 上拉加载
- (void)loadMoreComment
{
//    [self.tableView.mj_header endRefreshing];
    [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.punCellItem.ID;
    parameters[@"per"] = @(loadCount);
    // 每次加载后的上一页的最后一个, 注意是不断变化的元素
    HXLEssenceCommentItem *cmtItem = self.commentArray.lastObject;
    parameters[@"lastcid"] = cmtItem.ID;
    // 刷新下一页, 参数加1, 但不赋值, 刷新不成功也不会更改 self.page 的真实值
    parameters[@"page"] = @(self.page + 1);
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        WriteToPlist(responseObject, @"Comment", @(self.collectionCellType));
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) { // 如果没有数据;
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = YES;
            return ;
        }
        
        self.responseObject = responseObject;
        // 记录保存数据, 并刷新
        NSMutableArray *array = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.commentArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        // 刷新成功让页码 + 1;
        self.page += 1;
        
        // 判断
        [self alldataDidLoadByPullup];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [self.tableView.mj_footer endRefreshing];
        
        if (error) {
            NSLog(@"%@", error);
        }
        
    }];
}


#pragma mark - TableView Delegate or DataSource
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotArray.count) return 2;
    if (self.commentArray.count) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 隐藏尾部控件
    tableView.mj_footer.hidden = (self.commentArray.count == 0);
    
    if (0 == section) {
        
        return self.hotArray.count? self.hotArray.count : self.commentArray.count;
    }
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     HXLCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cmt_reuseID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        cell.commentItem = self.hotArray.count ? self.hotArray[indexPath.row] : self.commentArray[indexPath.row];
        
    } else {
        
        cell.commentItem = self.commentArray[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HXLHeaderFooterView *headerFooterView = [HXLHeaderFooterView headerFooterViewWithTableView:tableView];
    // 对应组头标题
    headerFooterView.label.text = (0 == section) ? (
                                   self.hotArray.count ? @"最热评论" : @"最新评论"
                                   ) : @"最新评论";
    
    if (1 == section) {
        // 很多时候对于复杂的需求包裹一层, 是很管用的
        headerFooterView.header.y = essenceMargin_y;
        headerFooterView.height = heightForHeaderInSection + essenceMargin_y;
    }
    
    return headerFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0 == section ? heightForHeaderInSection : (heightForHeaderInSection + essenceMargin_y);
    
}



 
@end
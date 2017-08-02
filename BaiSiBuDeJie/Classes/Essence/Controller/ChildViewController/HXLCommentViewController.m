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

#pragma mark - Setup Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 统一设置区域
    [self setupUniformStyle];
    // 网络加载
    [self setupRefresh];

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

#pragma mark - 抽取的方法 from Init Setting
- (void)setupUniformStyle
{
    // 基本设置
    [self setupBase];
    
    // 搭建 tableView 的头部视图
    [self setupTableHeaderView];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)setupBase
{
    // 右侧导航 item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemImage:[UIImage imageNamed:@"comment_nav_item_share_icon"] selectedImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] addTarget:self action:@selector(rightBarButtonItemClick:) contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -DIY) forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    
    self.title = @"评论";
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 系统滚动内边距调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, TABBAR_HEIGHT, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 去掉 多余 cell 中的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    // 注册 cell;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:cmt_reuseID];
}

// 搭建 tableView 的头部视图
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

- (void)rightBarButtonItemClick:(UIBarButtonItem *)sender
{
    NSLog(@"右侧分享按钮点击");
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

#pragma mark - 设置蒙板跟弹窗口区域
- (void)setupCoverView:(CGRect)frame
{
    HXLCoverView *coverView = [HXLCoverView coverViewWithFrame:frame];
    HXLPopMenu *popMenu = [HXLPopMenu popMenu];
    self.popMenu = popMenu;
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTap)];
    [coverView addGestureRecognizer:tapGest];
    
    [popMenu showInCenter:coverView.center animateWithDuration:self.duration completion:^{
        [coverView show];
    }];
    
    // 定义 popMenBlock
    HXL_WEAKSELF;
    self.popMenu.popMenBlock = ^() {
        HXL_STRONGSELF;
        
        [strongSelf.popMenu hideInCenter:CGPointZero animateWithDuration:strongSelf.duration completion:^{
            [coverView removeFromSuperview];
        }];
        
        [strongSelf.view endEditing:YES];
    };
    
}

- (void)coverViewTap
{
    self.popMenu.popMenBlock();
}

#pragma mark - LoadData
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

#pragma mark - 抽取的方法 from LoadData
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
        self.tableView.mj_footer.hidden = YES;
    } else {
        // 结束刷新状态
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark - TableView Delegate or DataSource
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
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
    cell.commentItem = [self itemByIndexPath:indexPath];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    HXLCommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // 重复点击同一个 cell 时, 让 menu 消失;
    if (menu.isMenuVisible) { // 当点击另一个 cell 时, 失去响应者的 menu 会变成不可见, 所以此判断才成立.
        [menu setMenuVisible:NO animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
        [cell becomeFirstResponder];
        UILabel *coment = [cell valueForKey:@"comment"];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding, replay, report];
        [menu setTargetRect:coment.bounds inView:coment];
        [menu setMenuVisible:YES animated:YES];
    
    //消除cell选择痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 抽取的方法 From/TableView Delegate or DataSource
- (HXLEssenceCommentItem *)itemByIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        HXLEssenceCommentItem *commentItem = self.hotArray.count ? self.hotArray[indexPath.row] : self.commentArray[indexPath.row];
        return commentItem;
    }
    
    return self.commentArray[indexPath.row];
}

- (void)ding:(UIMenuController *)menu
{
    [self getContent];
}

- (void)replay:(UIMenuController *)menu
{
    [self getContent];
}

- (void)report:(UIMenuController *)menu
{
    [self getContent];
}

- (void)getContent {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HXLEssenceCommentItem *cmtItem = [self itemByIndexPath:indexPath];
    NSString *content = cmtItem.content;
    
    [self.commentTF becomeFirstResponder];
    NSLog(@"%@", content);
}

 
@end

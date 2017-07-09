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

#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"


#import "HXLSessionManager.h"
#import "MJExtension.h"


@interface HXLCommentViewController ()<UITableViewDataSource, UITableViewDelegate, HXLPopMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTF;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
/** 网络会话管理者 */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;
/** 最新模型数组 */
@property (nonatomic, readwrite, strong) NSArray *commentArray;
/** 最热模型数组 */
@property (nonatomic, readwrite, strong) NSArray *hotArray;
/** coverView */
@property (nonatomic, readwrite, strong) HXLCoverView *coverView;
/** popMenu */
@property (nonatomic, readwrite, strong) HXLPopMenu *popMenu;
/** duration */
@property (nonatomic, readwrite, assign) CGFloat duration;

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

- (NSArray *)commentArray
{
    if (!_commentArray) {
        NSArray *commentArray = [NSArray array];
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
    [self loadNewComment];
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
     HXL_WEAKSELF(popMenu)
    popMenu.popMenBlock = ^() {
        [weakSelf hideInCenter:CGPointZero animateWithDuration:self.duration completion:^{
            [self.coverView removeFromSuperview];
        }];
        
        [self.view endEditing:YES];
    };

}

- (void)coverViewTap
{
    self.popMenu.popMenBlock();
}

#pragma mark - loadData
- (void)loadNewComment
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.punCellItem.ID;
    parameters[@"per"] = @20;
    parameters[@"hot"] = @1;
    
    [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {

        
        WriteToPlist(responseObject, @"Comment", @(self.collectionCellType));
        
        self.commentArray = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotArray = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
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
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cmt_header_reuseID];
    
    if (headerFooterView == nil) {
        // 创建 headerFooterView
        headerFooterView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:cmt_header_reuseID];
        headerFooterView.contentView.backgroundColor =  GRAY_PUBLIC_COLOR;
    }
    // 创建内部 header;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heightForHeaderInSection)];
    header.backgroundColor = WHITE_COLOR;
    [headerFooterView addSubview:header];
    // 创建内部 label;
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT_13;
    label.frame = CGRectMake(essenceMargin_x, DIY, SCREEN_WIDTH - essenceMargin_x * 2, essenceMargin_x * 2);
    label.textColor = GRAY_COLOR;
    [header addSubview:label];
    
    // 对应组头标题
    label.text = (0 == section) ? (
                                   self.hotArray.count ? @"最热评论" : @"最新评论"
                                   ) : @"最新评论";
    
    if (1 == section) {
        // 很多时候对于复杂的需求包裹一层, 是很管用的
        header.y = essenceMargin_y;
    }
    
    
    return headerFooterView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0 == section ? heightForHeaderInSection : (heightForHeaderInSection + essenceMargin_y);
    
}



 
@end

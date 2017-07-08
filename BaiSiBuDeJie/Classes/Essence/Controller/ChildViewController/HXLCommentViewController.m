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

#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"


#import "HXLSessionManager.h"
#import "MJExtension.h"


@interface HXLCommentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

/** 网络会话管理者 */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;
/** 最新模型数组 */
@property (nonatomic, readwrite, strong) NSArray *commentArray;
/** 最热模型数组 */
@property (nonatomic, readwrite, strong) NSArray *hotArray;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSpace.constant = SCREEN_HEIGHT - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

// 供所继承的导航控制器调用
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)setupUniformStyle
{
    // 基本设置 comment_nav_item_share_icon_click
    self.title = @"评论";
    self.tableView.estimatedRowHeight = 44;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, TABBAR_HEIGHT, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    // 搭建 tableView 的头部视图
    [self setupTableHeaderView];
    
    // 注册 cell;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HXLCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:cmt_reuseID];
}

#pragma mark - 优化抽取的方法
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
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor =  WHITE_COLOR;
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT_13;
    label.frame = CGRectMake(essenceMargin_x, DIY, SCREEN_WIDTH - essenceMargin_x * 2, essenceMargin_x * 2);
    label.textColor = GRAY_COLOR;
    
    [headerView addSubview:label];
    
    label.text = @"最新评论";
    
    if (0 == section) {
       label.text = self.hotArray.count ? @"最热评论" : @"最新评论";
    }
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = GRAY_COLOR;
//    if (section == 1 || !self.hotArray.count) {
//        return nil;
//    }
//    return headerView;
//}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}

#pragma mark - 用代码实现 cell 的分割线起始位置 iOS8开始有变化
-(void)viewDidLayoutSubviews
{ // 方法一:
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
}

/** 方法二:
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
*/
 
@end

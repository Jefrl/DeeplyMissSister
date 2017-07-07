//
//  HXLCommentViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/7.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLCommentViewController.h"
#import "HXLPunTableViewCell.h"
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

}

// 供所继承的导航控制器调用
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)setupUniformStyle
{
    self.title = @"评论";
    self.tableView.estimatedRowHeight = 44;
    self.tableView.backgroundColor = RED_COLOR;
    HXLPunTableViewCell *headerView = [HXLPunTableViewCell loadViewFormXib:0];
    headerView.punCellItem = self.punCellItem;
    self.tableView.tableHeaderView = headerView;
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

        
        WriteToPlist(responseObject, @"Comment", @(_punCellItem.type));
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
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = GREEN_COLOR;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return self.hotArray.count ? @"最热评论" : @"最新评论";
    }
    
    return @"最新评论";
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}



@end

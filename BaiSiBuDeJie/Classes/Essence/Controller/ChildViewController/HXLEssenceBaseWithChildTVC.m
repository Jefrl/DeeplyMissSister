//
//  HXLEssenceBaseWithChildTVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceBaseWithChildTVC.h"
#import "HXLPunTableVC.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "HXLSessionManager.h"

#import "HXLPunTableViewCell.h"
#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"

@interface HXLEssenceBaseWithChildTVC ()

/** HXLSessionManager 对象 */
@property (nonatomic, strong) HXLSessionManager *sessionManager;
/** 帖子模型数组 */
@property (nonatomic, strong) NSArray *itemArray;
/** 帖子中评论的模型数组 */
@property (nonatomic, strong) NSArray *commentItemArray;
/** responseDict */
@property (nonatomic, strong) NSDictionary *responseDict;
/** cell 保存 */
@property (nonatomic, strong) HXLPunTableViewCell *cell;
/** dict */
@property (nonatomic, strong) NSDictionary *dict;
/** containBottomViewHight */
@property (nonatomic, assign) CGFloat containBottomViewHight;


/** latestComments 最新评论数组 */
@property (strong, nonatomic) NSMutableArray *latestComments;
/** 包含 hots 热评论数组 的二维大数组 */
@property (nonatomic, strong) NSMutableArray *allHots;

@end

@implementation HXLEssenceBaseWithChildTVC
- (NSMutableArray *)hots
{
    if (!_allHots) {
        NSMutableArray *arrM = [NSMutableArray array];
        _allHots = arrM;
    }
    return _allHots;
}

- (NSMutableArray *)latestComments
{
    if (!_latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}

- (NSArray *)itemArray {
    if (!_itemArray) {
        NSArray *itemArray = [NSArray array];
        _itemArray = itemArray;
    }
    return _itemArray;
}

- (NSArray *)commentItemArray
{
    if (!_commentItemArray) {
        _commentItemArray = [NSArray array];
    }
    return  _commentItemArray;
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

- (void)setupUniformStyle {
    
    self.tableView.backgroundColor = ORANGE_COLOR;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一风格;
    [self setupUniformStyle];
    // 初始化网络数据
    [self setupData];
}

- (void)test
{
    
}

- (void)setupData {
    // 请求不同类型贴子的参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    // 将数字包装成对象, AFN内部会处理;
    params[@"type"] = @(self.type);
    params[@"c"] = @"data";
    // 请求发出
    NSLog(@"");
    [self.sessionManager request:RequestTypeGet urlStr:HXLPUBLIC_URL parameters:params resultBlock:^(id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        // 字典数组转 模型数组
        self.itemArray = [HXLEssenceItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.responseDict = responseObject;
        WriteToPlist(_responseDict, @"pun", @(self.type))
        
        //--test 查看json 数据结构--
        
        // 获得新数据, 刷新界面
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXLPunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pun_reuseID forIndexPath:indexPath];
    
    HXLEssenceItem *item = self.itemArray[indexPath.row];
    cell.punCellItem = item;

    //    cell.containBottomView.hidden = YES;
    _cell = cell;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    HXLEssenceItem *item = self.itemArray[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXLEssenceItem *item = _itemArray[indexPath.row];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = item.ID;
    params[@"hot"] = @"1";
    
    [self.sessionManager request:RequestTypeGet urlStr:HXLPUBLIC_URL parameters:params resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@", error); return ;
        }
       
        // 字典数组 -> 转模型数组
        self.allHots = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.commentItemArray = [HXLEssenceCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        item.hotArray = _allHots;
        [self.tableView reloadData];
    }];
    
    return item.cellHeight;
}

@end

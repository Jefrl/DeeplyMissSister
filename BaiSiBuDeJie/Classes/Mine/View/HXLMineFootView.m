//
//  HXLMineFootView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineFootView.h"
#import "HXLMineWebViewController.h"

#import "HXLSessionManager.h"

#import "HXLSquareItem.h"

#import "HXLSquareButton.h"

#import "MJExtension.h"

@interface HXLMineFootView ()
/** sessionM */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;
/** squares */
@property (nonatomic, readwrite, strong) NSArray *squares;
/** squareBtnArray */
@property (nonatomic, readwrite, strong) NSArray *squareBtnArray;
/** squareHeight */
@property (nonatomic, readwrite, assign) CGFloat squareHeight;
/** squareWidth */
@property (nonatomic, readwrite, assign) CGFloat squareWidth;
/** rows */
@property (nonatomic, readwrite, assign) CGFloat rows;

@end

@implementation HXLMineFootView

#pragma mark - Lazy load
- (NSArray *)squareBtnArray
{
    if (!_squareBtnArray) {
        NSArray *arrayM = [NSArray array];
        _squareBtnArray = arrayM;
    }
    return _squareBtnArray;
}

- (NSArray *)squares
{
    if (!_squares) {
        NSArray *array = [[NSArray alloc] init];
        _squares = array;
    }
    return _squares;
}

- (HXLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        HXLSessionManager *sessionManager = [HXLSessionManager manager];
        _sessionManager = sessionManager;
    }
    return _sessionManager;
}

#pragma mark - View 的构造方法;
- (instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = BLUE_COLOR;
    
    if (self = [super initWithFrame:frame]) {
        NSMutableDictionary *paramenter = [NSMutableDictionary dictionary];
        paramenter[@"a"] = @"square";
        paramenter[@"c"] = @"topic";
        
        
        [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:paramenter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            WriteToPlist(responseObject, @"Mine", @"tag");
            
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                NSLog(@"responseObject, 不是字典, 无数据");
                return ;
            }
            
            self.squares = [HXLSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方格;
            [self createSquares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"%@", error);
            }
        }];
    }
    
    return self;
}

#pragma mark - 功能方法
- (void)createSquares
{
    // 获取当前方格, 所在行列的索引
    NSMutableArray *arrayM = [NSMutableArray array];
    for (HXLSquareItem *item in self.squares) {
        HXLSquareButton *squareBtn = [HXLSquareButton buttonWithType:UIButtonTypeCustom];
        // 绑定模型, 不用 tag 了
        squareBtn.squareItem = item;

        // 注册点击事件
        [squareBtn addTarget:self action:@selector(squareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [arrayM addObject:squareBtn];
        
        [self addSubview:squareBtn];

        // 计算一下所有方格排列后的高度
        [self countSquareHeight];

    }
    // 保存方格按钮
    self.squareBtnArray = arrayM;
}

- (void)countSquareHeight
{
    // 方格的个数
    NSInteger count = self.squares.count;
    _rows = ((count - 1) / cols) + 1;
    // 方格的宽高
    _squareWidth = SCREEN_WIDTH / cols;
    _squareHeight = _squareWidth;
    // 底部滚动需要调整高度
    self.height = _rows * _squareHeight;
    NSLog(@"%.2f", self.height);
}

- (void)squareBtnClick:(HXLSquareButton *)sender
{
    if (![sender.squareItem.url hasPrefix:@"http:"]) { // 有网页才跳转
        NSLog(@"%@", sender.squareItem.url);
        return;
    }
    
    // 由于自身为 footView 而已不是当前控制器, 所以要用根控制器, 获取selectedViewController(此控制器才为 nav)
    UITabBarController *tabBarController = (UITabBarController *)KEYWINDOW.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
    HXLMineWebViewController *webViewController = [[HXLMineWebViewController alloc] init];

    webViewController.title = sender.squareItem.name;
    webViewController.url = sender.squareItem.url;
    
    [nav pushViewController:webViewController animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置子控件的 frame
    NSInteger i = 0;
    for (HXLSquareButton *squareBtn in  self.squareBtnArray) {
        // 当前按钮所在行索引, 列索引;
        NSInteger indexRow = i / cols;
        NSInteger indexCol = i % cols;
        
        CGFloat x = indexCol * _squareWidth;
        CGFloat y = indexRow * _squareHeight;
        
        squareBtn.frame = CGRectMake(x, y, _squareWidth, _squareHeight);
        i++;
    }
}

@end

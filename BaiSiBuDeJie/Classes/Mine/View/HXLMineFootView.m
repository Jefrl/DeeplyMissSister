//
//  HXLMineFootView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineFootView.h"

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
        
        squareBtn.squareItem = item;
        [arrayM addObject:squareBtn];
        
        [self addSubview:squareBtn];
    }
    // 保存方格按钮
    self.squareBtnArray = arrayM;
    NSLog(@"%@", self.squareBtnArray);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.squares.count;
    // 总列数与行数
    NSInteger cols = 4;
    NSInteger rows = ((count - 1) / cols) + 1;
    
    // 方格的宽高
    CGFloat squareWidth = SCREEN_WIDTH / cols;
    CGFloat squareHeight = squareWidth;
    
    // 设置子控件的 frame
    NSInteger i = 0;
    for (HXLSquareButton *squareBtn in  self.squareBtnArray) {
        // 当前按钮所在行索引, 列索引;
        NSInteger indexRow = i / cols;
        NSInteger indexCol = i % cols;
        
        CGFloat x = indexCol * squareWidth;
        CGFloat y = indexRow * squareHeight;
        
        squareBtn.frame = CGRectMake(x, y, squareWidth, squareHeight);
        
        i++;
        
        NSLog(@"%@", NSStringFromCGRect(squareBtn.frame));
    }
    
    // 设置 footView 的高度;
    self.height = rows * squareHeight;
}

@end

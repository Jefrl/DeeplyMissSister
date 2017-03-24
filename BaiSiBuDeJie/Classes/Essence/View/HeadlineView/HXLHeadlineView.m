//
//  HXLHeadlineView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLHeadlineView.h"

@interface HXLHeadlineView ()
/** titleCount 标题个数 */
@property (nonatomic, assign) NSInteger titleCount;
/** titleWidth 标题宽度 */
@property (nonatomic, assign)  CGFloat titleWidth;
/** totalWidth 标题总宽度 */
@property (nonatomic, assign)  CGFloat totalWidth;
/** titleWidth 标题间隙宽度 */
@property (nonatomic, assign)  CGFloat titleMargin;
/** headlineBtn_arr 按钮数组 */
@property (nonatomic, strong) NSMutableArray *headlineBtn_arr;
/** lastBtnIndex 记录上一个按钮的 tag 为索引 */
@property (nonatomic, assign) NSInteger lastBtnIndex;
/** underline 下划线保存 */
@property (nonatomic, weak) UIView *underline;
/** headlineView */
@property (nonatomic, weak) UIScrollView *headlineView;


@end

@implementation HXLHeadlineView
- (NSMutableArray *)headlineBtn_arr {
    if (!_headlineBtn_arr) {
        _headlineBtn_arr = [NSMutableArray array];
    }
    return _headlineBtn_arr;
}

- (instancetype)setupHeadlineViewWithArray:(NSArray *)headlineVC_arr {
    // headlineView 的创建
    HXLHeadlineView *headlineView = [[HXLHeadlineView alloc] init];
    headlineView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, HeadlineView_height);
    headlineView.backgroundColor = BLACK_COLOR;
    _headlineView = headlineView;
    
    // headlineBtn.frame 的良性判定算法
    _titleCount = headlineVC_arr.count;
    for (NSInteger i= 0; i< _titleCount; i++) {

        UIViewController *childVC = headlineVC_arr[i];
        CGRect titleBounds = [childVC.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:23]} context:nil];
        // 标题宽度
        _titleWidth = titleBounds.size.width;
        _totalWidth += _titleWidth;
        if (i < _titleCount -1) continue;
        // 标题间隙
        if (_totalWidth > SCREEN_WIDTH) {
            _titleMargin = Margin;
        } else {
            
        _titleMargin = (SCREEN_WIDTH - _totalWidth) / (_titleCount + 1);
        _titleMargin = _titleMargin < Margin? Margin: _titleMargin;
        }
    }
    
    // headlineBtn 的创建
    for (NSInteger i= 0; i< _titleCount; i++) {
        
        UIViewController *childVC = headlineVC_arr[i];
        HXLHeadlineBtn *headlineBtn = [HXLHeadlineBtn buttonWithType:UIButtonTypeCustom];
        [headlineBtn setTitle:childVC.title forState:UIControlStateNormal];
        headlineBtn.titleLabel.font = FONT_15;
        headlineBtn.tag = i;
        [headlineBtn addTarget:self action:@selector(headlineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 保存到数组
        [self.headlineBtn_arr addObject:headlineBtn];
        
        // 设置 frame;
        CGFloat headlineBtn_x = _titleMargin + (_titleMargin + _titleWidth) * i;
        CGFloat headlineBtn_y = 0;
        CGFloat headlineBtn_width = _titleWidth;
        CGFloat headlineBtn_hight = HeadlineView_height;
        headlineBtn.frame = CGRectMake(headlineBtn_x, headlineBtn_y, headlineBtn_width, headlineBtn_hight);
        [headlineView addSubview:headlineBtn];
    }
    // contentSize 设置
    headlineView.contentSize = CGSizeMake(_totalWidth + _titleMargin * (_titleCount + 1), HeadlineView_height);
    
    self.lastBtnIndex = 0;
    // 下划线
    UIView *underline = [[UIView alloc] init];
    self.underline = underline;
    _underline.backgroundColor = RED_COLOR;
    
    UIButton *selectBtn = _headlineBtn_arr[_lastBtnIndex];
    [selectBtn.titleLabel sizeToFit];
    _underline.size = CGSizeMake(selectBtn.width, 2);
    _underline.centerX = selectBtn.centerX;
    _underline.y = selectBtn.height - 2;
    
    NSLog(@"%@", NSStringFromCGRect(_underline.frame));
//    [self moveUnderlineUnderBtn:_headlineBtn_arr[_lastBtnIndex]];
    
    [headlineView addSubview:_underline];
    
    return headlineView;
}

- (void)moveUnderlineUnderBtn: (UIButton *)selectBtn {
    NSLog(@"%@", selectBtn);

    NSLog(@"%@", NSStringFromCGRect(_underline.frame));
}

/** headlineBtn 的点击事件 */
- (void)headlineBtnClick:(UIButton *)headlineBtn {
    if (headlineBtn.tag == 0) {
        
        // 下划线
        UIView *underline = [[UIView alloc] init];
        self.underline = underline;
        _underline.backgroundColor = RED_COLOR;
        
        UIButton *selectBtn = headlineBtn;
        [selectBtn.titleLabel sizeToFit];
        _underline.size = CGSizeMake(selectBtn.width, 2);
        _underline.centerX = selectBtn.centerX;
        _underline.y = selectBtn.height - 2;
        
        NSLog(@"%@", NSStringFromCGRect(_underline.frame));
        //    [self moveUnderlineUnderBtn:_headlineBtn_arr[_lastBtnIndex]];
        
        [_headlineView addSubview:_underline];
        
        NSLog(@"%@, %@", NSStringFromCGRect(_underline.frame), NSStringFromCGRect(headlineBtn.frame));
        
    } else if (headlineBtn.tag == 1) {
        NSLog(@"%ld", headlineBtn.tag);
        // 下划线
        UIView *underline = [[UIView alloc] init];
        self.underline = underline;
        _underline.backgroundColor = RED_COLOR;
        
        UIButton *selectBtn = headlineBtn;
        [selectBtn.titleLabel sizeToFit];
        _underline.size = CGSizeMake(selectBtn.width, 2);
        _underline.centerX = selectBtn.centerX;
        _underline.y = selectBtn.height - 2;
        
        [_headlineView addSubview:_underline];
        NSLog(@"%@, %@", NSStringFromCGRect(_underline.frame), NSStringFromCGRect(headlineBtn.frame));
        
    } else if (headlineBtn.tag == 2) {
        // 下划线
        UIView *underline = [[UIView alloc] init];
        self.underline = underline;
        _underline.backgroundColor = RED_COLOR;
        
        UIButton *selectBtn = headlineBtn;
        [selectBtn.titleLabel sizeToFit];
        _underline.size = CGSizeMake(selectBtn.width, 2);
        _underline.centerX = selectBtn.centerX;
        _underline.y = selectBtn.height - 2;
        
        [_headlineView addSubview:_underline];
        NSLog(@"%@, %@", NSStringFromCGRect(_underline.frame), NSStringFromCGRect(headlineBtn.frame));
        
    } else if (headlineBtn.tag == 3) {
        NSLog(@"%ld", headlineBtn.tag);
        
        // 下划线
        UIView *underline = [[UIView alloc] init];
        self.underline = underline;
        _underline.backgroundColor = RED_COLOR;
        
        UIButton *selectBtn = headlineBtn;
        [selectBtn.titleLabel sizeToFit];
        _underline.size = CGSizeMake(selectBtn.width, 2);
        _underline.centerX = selectBtn.centerX;
        _underline.y = selectBtn.height - 2;
        
        [_headlineView addSubview:_underline];
        NSLog(@"%@, %@", NSStringFromCGRect(_underline.frame), NSStringFromCGRect(headlineBtn.frame));
        
    } else if (headlineBtn.tag == 4) {
        // 下划线
        UIView *underline = [[UIView alloc] init];
        self.underline = underline;
        _underline.backgroundColor = RED_COLOR;
        
        UIButton *selectBtn = headlineBtn;
        [selectBtn.titleLabel sizeToFit];
        _underline.size = CGSizeMake(selectBtn.width, 2);
        _underline.centerX = selectBtn.centerX;
        _underline.y = selectBtn.height - 2;
        
        [_headlineView addSubview:_underline];
        NSLog(@"%@, %@", NSStringFromCGRect(_underline.frame), NSStringFromCGRect(headlineBtn.frame));
        
    }
}


@end

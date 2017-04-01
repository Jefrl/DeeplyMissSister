//
//  HXLHeadlineView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLHeadlineView.h"

@interface HXLHeadlineView ()<UIScrollViewDelegate>
/** titleCount 标题个数 */
@property (nonatomic, assign) NSInteger titleCount;
/** titleWidth 标题宽度 */
@property (nonatomic, assign)  CGFloat titleWidth;
/** totalWidth 标题总宽度 */
@property (nonatomic, assign)  CGFloat totalWidth;
/** titleWidth 标题间隙宽度 */
@property (nonatomic, assign)  CGFloat titleMargin;
/** titleWidths 按钮宽度数组 */
@property (nonatomic, strong) NSMutableArray *titleWidths;
/** currentOffset */
@property (nonatomic, assign) CGFloat currentOffset;
/** underline 下划线保存 */
@property (nonatomic, weak) UIView *underline;


@end

@implementation HXLHeadlineView
- (NSMutableArray *)titleWidths
{
    if (!_titleWidths) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
- (NSMutableArray *)headlineBtn_arr {
    if (_headlineBtn_arr == nil) {
        _headlineBtn_arr = [NSMutableArray array];
    }
    return _headlineBtn_arr;
}
// _titleMargin的良性判定算法
- (void)setTitleMarginWithArray:(NSArray *)headlineVC_arr titleFont:(UIFont *)titleFont
{
    _titleCount = headlineVC_arr.count;
    for (NSInteger i= 0; i< _titleCount; i++) {
        UIViewController *childVC = headlineVC_arr[i];
        CGRect titleBounds = [childVC.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil];
        // 标题宽度
        _titleWidth = titleBounds.size.width + Margin;
        [self.titleWidths addObject:[NSNumber numberWithFloat:_titleWidth]];
        
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
}

- (instancetype)initWithHeadlineViewWithArray:(NSArray *)headlineVC_arr
{
    // headlineBtn.frame 的良性判定算法
    [self setTitleMarginWithArray:headlineVC_arr titleFont:TitleFont];
    
    // headlineView 的创建
    self = [super init];
    if (!self) return nil;
    self.backgroundColor = BLACK_COLOR;
    self.showsHorizontalScrollIndicator = NO;
    // contentSize 设置
    self.contentSize = CGSizeMake(_totalWidth + _titleMargin * (_titleCount + 1), HeadlineView_height);
    
    // headlineBtn 的创建
    for (NSInteger i= 0; i< _titleCount; i++) {
        
        UIViewController *childVC = headlineVC_arr[i];
        HXLHeadlineBtn *headlineBtn = [HXLHeadlineBtn buttonWithType:UIButtonTypeCustom];
//        headlineBtn.backgroundColor = GREEN_COLOR;
        [headlineBtn setTitle:childVC.title forState:UIControlStateNormal];
        // 字体大小要注意与良性计算里的大小保持一致;
        headlineBtn.titleLabel.font = TitleFont;
        headlineBtn.tag = i;
        [headlineBtn addTarget:self action:@selector(headlineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 保存到数组
        [self.headlineBtn_arr addObject:headlineBtn];
            
        if (i == 0) {
            _selectedBtnIndex = i;
            headlineBtn.titleLabel.font = FONT_15;
            [headlineBtn sizeToFit];
        }
        
        [self addSubview:headlineBtn];
    }

    // 下划线的创建
    UIView *underline = [[UIView alloc] init];
    self.underline = underline;
    _underline.backgroundColor = WHITE_COLOR;
    [self addSubview:_underline];

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, HeadlineView_height);
    
    // headlineBtn.frame 设置
    CGFloat tempWidth = 0;
    CGFloat currentWidth = 0;
    for (UIButton *headlineBtn in self.headlineBtn_arr) {
        NSInteger i = headlineBtn.tag;
        currentWidth = [_titleWidths[i] floatValue];
//        NSLog(@"%f", currentWidth);
        
        CGFloat headlineBtn_x = tempWidth + _titleMargin + _titleMargin * i;
        CGFloat headlineBtn_y = 0;
        CGFloat headlineBtn_width = currentWidth;
        CGFloat headlineBtn_hight = HeadlineView_height;
        headlineBtn.frame = CGRectMake(headlineBtn_x, headlineBtn_y, headlineBtn_width, headlineBtn_hight);
         
        tempWidth += currentWidth;
    }
    // 设置_underline 的 frame;
    if (_underline.height) return;
    UIButton *selectBtn = _headlineBtn_arr[_selectedBtnIndex];
    [selectBtn.titleLabel sizeToFit];
    _underline.size = CGSizeMake(selectBtn.width, Underline_height);
    _underline.centerX = selectBtn.centerX;
    _underline.y = selectBtn.height - Underline_height*2;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.contentOffset = CGPointMake(_currentOffset, 0);
}

- (void)moveUnderlineBtn: (UIButton *)headlineBtn {
    
    [UIView animateWithDuration:0.5 animations:^{
        // 下划线动画
        _underline.width = headlineBtn.width;
        _underline.centerX = headlineBtn.centerX;
        _currentOffset = headlineBtn.centerX - SCREEN_WIDTH * 0.5;
        // 记录上一个索引, 记录当前索引
        _lastBtnIndex = _selectedBtnIndex;
        _selectedBtnIndex = headlineBtn.tag;
        // 变化文字
        UIButton *lastBtn = _headlineBtn_arr[_lastBtnIndex];
        lastBtn.titleLabel.font = TitleFont;
        headlineBtn.titleLabel.font = FONT_15;
    } completion:nil];
    // headlineView 滚动;
    [self setContentOffset:CGPointMake(_currentOffset, 0) animated:YES];
    // 发通知联动;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"btn" object:nil];
}

/** headlineBtn 的点击事件 */
- (void)headlineBtnClick:(UIButton *)headlineBtn {
    if (headlineBtn.tag == 0) {
         [self moveUnderlineBtn:headlineBtn];
        
    } else if (headlineBtn.tag == 1) {
         [self moveUnderlineBtn:headlineBtn];
        
    } else if (headlineBtn.tag == 2) {
         [self moveUnderlineBtn:headlineBtn];
        
    } else if (headlineBtn.tag == 3) {
         [self moveUnderlineBtn:headlineBtn];
        
    } else if (headlineBtn.tag == 4) {
         [self moveUnderlineBtn:headlineBtn];
        
    }
}


@end

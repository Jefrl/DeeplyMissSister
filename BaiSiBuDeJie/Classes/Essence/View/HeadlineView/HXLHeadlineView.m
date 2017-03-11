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

@end

@implementation HXLHeadlineView

- (instancetype)setupHeadlineViewWithArray:(NSArray *)headlineVC_arr {
    // headlineView 的创建
    HXLHeadlineView *headlineView = [[HXLHeadlineView alloc] init];
    headlineView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, HeadlineView_height);
    headlineView.backgroundColor = BLACK_COLOR;
    
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
        headlineBtn.tag = i;
        [headlineBtn addTarget:self action:@selector(headlineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    return headlineView;
}

/** headlineBtn 的点击事件 */
- (void)headlineBtnClick:(UIButton *)headlineBtn {
    if (headlineBtn.tag == 0) {
        NSLog(@"%ld", headlineBtn.tag);
    } else if (headlineBtn.tag == 1) {
        NSLog(@"%ld", headlineBtn.tag);
    } else if (headlineBtn.tag == 2) {
        NSLog(@"%ld", headlineBtn.tag);
    } else if (headlineBtn.tag == 3) {
        NSLog(@"%ld", headlineBtn.tag);
    } else if (headlineBtn.tag == 4) {
        NSLog(@"%ld", headlineBtn.tag);
    }
}


@end

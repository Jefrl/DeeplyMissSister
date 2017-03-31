//
//  HXLHeadlineView.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLHeadlineView : UIScrollView
/** 创建 headlineView */
- (instancetype)initWithHeadlineViewWithArray:(NSArray *)headlineVC_arr;
/** moveUnderlineBtn */
- (void)moveUnderlineBtn: (UIButton *)headlineBtn;
/** headlineBtn_arr 按钮数组 */
@property (nonatomic, strong) NSMutableArray *headlineBtn_arr;
/** 记录选中按钮的 tag 为索引 */
@property (nonatomic, assign) NSInteger selectedBtnIndex;
/** 记录上一个按钮 tag */
@property (nonatomic, assign) NSInteger lastBtnIndex;

@end

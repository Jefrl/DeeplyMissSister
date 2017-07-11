//
//  HXLPopMenu.m
//  小码哥彩票
//
//  Created by 1 on 16/4/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "HXLPopMenu.h"

@implementation HXLPopMenu

- (IBAction)closeBtn:(UIButton *)sender
{
    self.popMenBlock();
//    // 通知外界
//    if ([self.delegate respondsToSelector:@selector(popMenuDidCloseBtn:)]) {
//        [self.delegate popMenuDidCloseBtn:self];
//    }
    
}

+ (instancetype)showInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration
{
    HXLPopMenu *popMenu = [HXLPopMenu loadViewFormXib:0];
    [UIView animateWithDuration:(duration * 0.8) animations:^{
        popMenu.center = center;
        [[UIApplication sharedApplication].keyWindow addSubview:popMenu];
    }];
    
    return popMenu;
}

- (void)hideInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration completion:(MyBlock)completion
{
    [UIView animateWithDuration:(duration * 0.8) animations:^{
        self.center = center;
        self.transform = CGAffineTransformMakeScale(0.7, 0.7);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        // 2.动画执行完毕移除蒙版
        if (completion) { // 判断外界有没有传递代码, 一般有移除自己的操作
            completion();
        }
    }];
    
}

@end
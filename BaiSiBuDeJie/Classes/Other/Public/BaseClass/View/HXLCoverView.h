//
//  HXLCoverView.h
//  小码哥彩票
//
//  Created by 1 on 16/4/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLCoverView : UIView

/**
 添加一块蒙板到主窗口上

 @param frame 蒙版的 frame
 */
+ (void)show:(CGRect)frame;

+ (void)hide;

@end

//
//  HXLConst.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/15.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
// 基类的容器控件上, 中的高度, 竖直, 水平方向的间隙值
CGFloat const containTopView_hight = 50;
CGFloat const containDingView_hight = 40;
CGFloat const cellMargin_y = 1;
CGFloat const essenceMargin_y = 10;
CGFloat const essenceMargin_x = 10;
CGFloat const DIY = 5;

// 基类(也是段子)的重用标识;
NSString * const pun_reuseID = @"punCell";
// 评论页面的重用标识;
NSString * const cmt_reuseID = @"cmtCell";
// 评论页面 section 头部重用标识
NSString * const cmt_header_reuseID = @"cmt_header";

// 评论页面 section 头部的高度
CGFloat const heightForHeaderInSection = 25;

/** tabBar被选中的通知名字 */
NSString * const HXLTabBarDidSelectNotification = @"HXLTabBarDidSelectNotification";


NSInteger const showHotCount = 3;

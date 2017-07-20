//
//  HXLConst.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/15.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HXLTopicTypeAll = 1,
    HXLTopicTypePicture = 10,
    HXLTopicTypeWord = 29,
    HXLTopicTypeVoice = 31,
    HXLTopicTypeVideo = 41
} HXLTopicType;

// 基类的容器控件上, 中的高度, 竖直, 水平方向的间隙值
UIKIT_EXTERN CGFloat const containTopView_hight;
UIKIT_EXTERN CGFloat const containDingView_hight;
UIKIT_EXTERN CGFloat const cellMargin_y;
UIKIT_EXTERN CGFloat const essenceMargin_y;
UIKIT_EXTERN CGFloat const essenceMargin_x;
// 只是为了透彻, setFrame 跟 layoutsubViews 的自娱;
UIKIT_EXTERN CGFloat const DIY;
// 用户头像 icon 的占位小图片名
UIKIT_EXTERN NSString *const placeholder;
// 用户头像 icon 的占位大图片名
UIKIT_EXTERN NSString *const bigplaceholder;

// 基类(也是段子)的重用标识;
UIKIT_EXTERN NSString * const pun_reuseID;
// 评论页面的重用标识;
UIKIT_EXTERN NSString * const cmt_reuseID;
// 评论页面 section 头部重用标识
UIKIT_EXTERN NSString * const cmt_header_reuseID;
// 评论页面 section 头部的高度
UIKIT_EXTERN CGFloat const heightForHeaderInSection;
// 我的页面的重用标识
UIKIT_EXTERN NSString * const mineCell;
// 我的页面中的 section 自动滚动距离
UIKIT_EXTERN CGFloat const mineSectionSroll;
// Mine 中方格总列数
UIKIT_EXTERN NSInteger const cols;
// 推荐关注页面中 Category 的重用标识
UIKIT_EXTERN NSString *const followCategoryReuseID;
// 推荐关注页面中 user 的重用标识
UIKIT_EXTERN NSString *const followUserReuseID;
// 推荐标签页面中的重用标识
UIKIT_EXTERN NSString *const recommentTagReuseID;
// 个人详情页面 tableView 下滚的调整距离
UIKIT_EXTERN CGFloat scrollValue;


/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const HXLTabBarDidSelectNotification;

// 网络加载自定义每次加载条数
UIKIT_EXTERN NSInteger const loadCount;
// 规定展示的热评数目
UIKIT_EXTERN NSInteger const showHotCount;

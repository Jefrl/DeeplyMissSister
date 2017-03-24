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
UIKIT_EXTERN CGFloat const containMidView_hight;
UIKIT_EXTERN CGFloat const cellMargin_y;
UIKIT_EXTERN CGFloat const essenceMargin_y;
UIKIT_EXTERN CGFloat const essenceMargin_x;
// 基类(也是段子)的重用标识;
UIKIT_EXTERN NSString * const pun_reuseID;

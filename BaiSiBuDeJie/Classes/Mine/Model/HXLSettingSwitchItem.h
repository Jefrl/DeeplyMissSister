//
//  HXLSettingSwitchItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/31.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSettingBaseItem.h"

@interface HXLSettingSwitchItem : HXLSettingBaseItem
/** 开关状态 */
@property (nonatomic, readwrite,  assign, getter=isOpen) BOOL open;

@end

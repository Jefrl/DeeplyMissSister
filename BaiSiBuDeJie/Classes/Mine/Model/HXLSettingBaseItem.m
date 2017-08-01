//
//  HHXLSettingBaseItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSettingBaseItem.h"

@implementation HXLSettingBaseItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    HXLSettingBaseItem *settingItem = [[self alloc] init];
    settingItem.title = title;
    settingItem.icon = icon;
    return settingItem;
}


@end

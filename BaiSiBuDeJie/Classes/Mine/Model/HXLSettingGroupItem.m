//
//  HXLSettingGroupItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSettingGroupItem.h"
#import "HXLSettingBaseItem.h"
// #import "MJExtension.h"

@implementation HXLSettingGroupItem
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"settingItemArray" : @"HXLSettingItem"};
//}

+ (instancetype)groupWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle andSettingItemArray:(NSArray *)settingItemArray
{
    HXLSettingGroupItem *groupItem = [[HXLSettingGroupItem alloc] init];
    groupItem.headerTitle = headerTitle;
    groupItem.footerTitle = footerTitle;
    groupItem.settingItemArray = settingItemArray;
    
    return groupItem;
}

@end

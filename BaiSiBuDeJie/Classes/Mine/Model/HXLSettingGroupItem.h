//
//  HXLSettingGroupItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HXLSettingGroupItem : NSObject
/** headerTitle */
@property (nonatomic, readwrite, strong) NSString *headerTitle;
/** footerTitle */
@property (nonatomic, readwrite, strong) NSString *footerTitle;
/** settingItem */
@property (nonatomic, readwrite, strong) NSArray *settingItemArray;

+ (instancetype)groupWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle andSettingItemArray:(NSArray *)settingItemArray;

@end

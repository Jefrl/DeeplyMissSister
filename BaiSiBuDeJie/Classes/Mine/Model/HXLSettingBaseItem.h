//
//  HXLSettingBaseItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLSettingBaseItem : NSObject

/** title */
@property (nonatomic, readwrite, strong) NSString *title;
/** imageView */
@property (nonatomic, readwrite, strong) NSString *icon;
/** 点击 cell 需要执行的代码块 */
@property (nonatomic, readwrite, copy) void (^operation)();

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

@end

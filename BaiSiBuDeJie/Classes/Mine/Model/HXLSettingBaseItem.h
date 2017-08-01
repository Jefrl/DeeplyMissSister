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
/** detailTitle */
@property (nonatomic, readwrite, strong) NSString *detailTitle;

/** 点击 cell 需要执行的代码块 */
@property (nonatomic, readwrite, copy) void (^operation)();
/** 带参数的 Block */
@property (nonatomic, readwrite, copy) void (^operationIndexPath)(NSIndexPath *indexPath);

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

///** 含有子标题的 cell 的设置 */
//+ (instancetype)itemWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle icon:(NSString *)icon;

@end

//
//  HXLEssenceItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceItem.h"
//#import "MJExtension.h"

@implementation HXLEssenceItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"id" : @"ID",
             @"image0" : @"small_image",
             @"image1" : @"middle_image",
             @"image2" : @"large_image"
             };
}


@end

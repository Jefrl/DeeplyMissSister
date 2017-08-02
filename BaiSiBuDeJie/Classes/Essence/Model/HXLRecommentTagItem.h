//
//  HXLRecommentTagItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/20.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLRecommentTagItem : NSObject
/** theme_id */
@property (nonatomic, readwrite, strong) NSString *theme_id;
/** 头像 */
@property (nonatomic, readwrite, strong) NSString *image_list;
/** 用户名 */
@property (nonatomic, readwrite, strong) NSString *theme_name;
/** sub_number */
@property (nonatomic, readwrite, strong) NSString *sub_number;
/** is_default */
@property (nonatomic, readwrite, assign) BOOL is_default;
/** is_sub */
@property (nonatomic, readwrite, assign)  BOOL is_sub;


@end



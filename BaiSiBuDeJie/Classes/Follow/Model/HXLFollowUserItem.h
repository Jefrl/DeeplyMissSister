//
//  HXLFollowUserItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/18.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLFollowUserItem : NSObject

/** uid */
@property (nonatomic, readwrite, assign) NSInteger uid;
/** 头像 */
@property (nonatomic, readwrite, strong) NSString *header;
/** fans_count */
@property (nonatomic, readwrite, strong) NSString *fans_count;
/** is_follow */
@property (nonatomic, readwrite, assign) BOOL is_follow;
/** is_vip */
@property (nonatomic, readwrite, assign)  BOOL is_vip;
/** 用户名 */
@property (nonatomic, readwrite, strong) NSString *screen_name;
/** 发帖数 */
@property (nonatomic, readwrite, assign) NSInteger tiezi_count;
/** 性别 1- 女, 2- 男 */
@property (nonatomic, readwrite, assign) NSInteger gender;
/** 描述 */
@property (nonatomic, readwrite, strong) NSString *introduction;

@end

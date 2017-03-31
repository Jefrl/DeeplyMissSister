//
//  HXLUser.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLUser : NSObject
/** 用户名 */
@property (nonatomic, strong) NSString *username;
/** 性别 */
@property (nonatomic, strong) NSString *sex;
/** 头像 */
@property (nonatomic, strong) NSString *profile_image;
@end

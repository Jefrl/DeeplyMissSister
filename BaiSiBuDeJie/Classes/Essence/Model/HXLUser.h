//
//  HXLUser.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/30.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXLUser : NSObject
/** 用户 id */
@property (nonatomic, readwrite, strong) NSString *ID;
/** 用户名 */
@property (nonatomic, strong) NSString *username;
/** 性别(性别：f为女，m为男) */
@property (nonatomic, strong) NSString *sex;
/** 轮廓头像 profile_image  */
@property (nonatomic, readwrite, strong) NSString *profile_image;
/** is_vip */
@property (nonatomic, readwrite, assign) BOOL is_vip;

/** total_cmt_like_count */
@property (nonatomic, readwrite, strong) NSString *total_cmt_like_count;
/** 个人主页 personal_page */
@property (nonatomic, readwrite, strong) NSString *personal_page;
/** qq_uid */
@property (nonatomic, readwrite, strong) NSString *qq_uid;
/** qzone_uid */
@property (nonatomic, readwrite, strong) NSString *qzone_uid;
/** weibo_uid */
@property (nonatomic, readwrite, strong) NSString *weibo_uid;


@end

/**
 <key>user</key>
 <dict>
 <key>id</key>
 <string>14661558</string>
 <key>is_vip</key>
 <false/>
 <key>personal_page</key>
 <string>http://user.qzone.qq.com/AD840426D8D05F953120DCE2A8D5DC37</string>
 <key>profile_image</key>
 <string>http://wimg.spriteapp.cn/profile/large/2017/01/20/5881aa8835dab_mini.jpg</string>
 <key>qq_uid</key>
 <string></string>
 <key>qzone_uid</key>
 <string>AD840426D8D05F953120DCE2A8D5DC37</string>
 <key>sex</key>
 <string>f</string>
 <key>total_cmt_like_count</key>
 <string>13</string>
 <key>username</key>
 <string>看阳光时明时暗</string>
 <key>weibo_uid</key>
 <string></string>
 </dict>
*/

//
//  HXLEssenceCommentItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/29.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXLUser;
@class HXLPrecmtUser;

@interface HXLEssenceCommentItem : NSObject
/** 用户 */
@property (nonatomic, strong) HXLUser *user;
/** 评论内容系统分配给的id编号(供加载下一页使用) */
@property (nonatomic, copy) NSString *ID;
/** 评论类型 cmt_type */
@property (nonatomic, readwrite, strong) NSString *cmt_type;
/** 评论内容 */
@property (nonatomic, readwrite, strong) NSString *content;
/** ctime发帖时间 */
@property (nonatomic, readwrite, strong) NSString *ctime;
/** 音频文件的时长 */
@property (nonatomic, strong) NSString *voicetime;
/** 音频文件的路径 */
@property (nonatomic, strong) NSString *voiceuri;
/** 该评论被点赞的数量 */
@property (nonatomic, strong) NSString *like_count;
/** precid(如果是评论之前的人的评论内容，则为前面帖子的评论id，如果不是则为0) */
@property (nonatomic, readwrite, strong) NSString *precid;
/** precmt (被评论的用户的信息字段) */
@property (nonatomic, readwrite, strong) HXLPrecmtUser *precmt;

@end

/**
<array>
<dict>
<key>cmt_type</key>
<string>29</string>
<key>content</key>
<string>好舒服的一首歌，怎么下载哇？</string>
<key>ctime</key>
<string>2017-01-06 21:18:01</string>
<key>data_id</key>
<string>15285835</string>
<key>id</key>
<string>72192297</string>
<key>like_count</key>
<string>2</string>
<key>precid</key>
<string>0</string>
<key>precmt</key>
<array/>
<key>preuid</key>
<string>0</string>
<key>status</key>
<string>0</string>


<key>voicetime</key>
<string></string>
<key>voiceuri</key>
<string></string>
</dict>
*/

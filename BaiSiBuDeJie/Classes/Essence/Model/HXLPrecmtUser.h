//
//  HXLPrecmtUser.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/8.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXLUser;

@interface HXLPrecmtUser : NSObject
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
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** precid(如果是评论之前的人的评论内容，则为前面帖子的评论id，如果不是则为0) */
@property (nonatomic, readwrite, strong) NSString *precid;

///** precmt (被评论的用户的信息字段) */
//@property (nonatomic, readwrite, strong) HXLPrecmtUser *precmt;


@end

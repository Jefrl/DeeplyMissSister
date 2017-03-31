//
//  HXLEssenceItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXLEssenceCommentItem;
@interface HXLEssenceItem : NSObject
/** 帖子的类型 */
@property (nonatomic, assign)  HXLTopicType type;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_at;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, strong) NSString *ding;
/** 踩的数量 */
@property (nonatomic, strong) NSString *cai;
/** 转发的数量 */
@property (nonatomic, strong) NSString *repost;
/** 评论的数量 */
@property (nonatomic, strong) NSString *comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** is_gif 是 GIF图片 */
@property (nonatomic, assign) BOOL is_gif;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 最热评论数组 */
@property (nonatomic, strong) NSArray *top_cmt;

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** qzone_uid */
//@property (nonatomic, copy) NSString *qzone_uid;

/****** 额外的辅助属性 ******/
/** 帖子中所有热评用户评论数组 */
@property (nonatomic, strong)  NSArray *hotArray;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureFrame;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceFrame;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoFrame;

@end

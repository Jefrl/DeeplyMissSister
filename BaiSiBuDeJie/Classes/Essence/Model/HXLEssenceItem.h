//
//  HXLEssenceItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLEssenceItem : NSObject
/** 帖子的类型 */
@property (nonatomic, assign)  HXLTopicType type;
/** id */
@property (nonatomic, strong) NSString *ID;
/** 名称 */
@property (nonatomic, strong) NSString *name;
/** 头像的URL */
@property (nonatomic, strong) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, strong) NSString *created_at;
/** 文字内容 */
@property (nonatomic, strong) NSString *text;
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
/** isRealGif */
@property (nonatomic, readwrite, assign) BOOL isRealGif;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 最热评论数组 */
@property (nonatomic, strong) NSArray *top_cmt;

/** gif 图片 */
@property (nonatomic, strong) NSString *gifFistFrame;
/** 小图片的URL */
@property (nonatomic, strong) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, strong) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, strong) NSString *large_image;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** qzone_uid */
//@property (nonatomic, copy) NSString *qzone_uid;

/****** 额外的辅助属性 ******/
///** 是否存在热评 */
//@property (nonatomic, assign) BOOL isExistHotComment;
///** 帖子中所有用户热评模型数组 */
//@property (nonatomic, strong)  NSArray *hotArray;
/** 热评的最大下标值 */
@property (nonatomic, assign)  NSUInteger maxIndex;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureFrame;
/** 图片是否太大 */
@property (nonatomic, assign) BOOL isBigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat currentProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceFrame;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoFrame;

@end

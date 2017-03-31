//
//  HXLEssenceCommentItem.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/29.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXLUser;

@interface HXLEssenceCommentItem : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) HXLUser *user;

@end

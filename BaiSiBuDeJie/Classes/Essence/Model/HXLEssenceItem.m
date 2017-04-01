//
//  HXLEssenceItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"
#import "HXLUser.h"

#import "MJExtension.h"
@interface HXLEssenceItem ()

@end

@implementation HXLEssenceItem
{
    CGFloat _cellHeight;
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id", // 调用大写 ID时, 本质是传了真实的 id 值;
             @"small_image"  : @"image0",
             @"middle_image" : @"image1",
             @"large_image"  : @"image2"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{ // 调用字典数组时, 本质用模型数组替换了, 可以取HXLEssenceCommentItem 类里的属性了;
             @"top_cmt" : @"HXLEssenceCommentItem"
             };
}

// 计算出每个模型的高度
- (CGFloat)cellHeight
{
//    if (!_cellHeight) {
    
        // 1. 基础通用高度
        CGSize text_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 2, MAXFLOAT);
        CGSize hotC_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 4, MAXFLOAT);
        // 1.1 帖子描述文字高度
        CGFloat textHight = [self.text boundingRectWithSize:text_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_17} context:nil].size.height;
        
        _cellHeight = essenceMargin_y + containTopView_hight + (textHight + essenceMargin_y * 2) + containMidView_hight + cellMargin_y;
        NSLog(@"%.f", _cellHeight );  
        // 2. 热评的高度
        if (self.isExistHotComment) {// 存在热评模型 (至少一条热评)
            CGFloat __block _tmpHeight = 0;
            [self.hotArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HXLEssenceCommentItem *hotItem = obj;
                HXLUser *user = hotItem.user;
                NSString *content = [NSString stringWithFormat:@"%@:  %@", user.username, hotItem.content];
                CGFloat labelHeight = [content boundingRectWithSize:hotC_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_14} context:nil].size.height;
                //
                _tmpHeight = essenceMargin_y + labelHeight;
                if (idx == self.maxIndex) *stop = YES;
                
            }];
            
            _cellHeight = _cellHeight + _tmpHeight + 2 * essenceMargin_y;
            NSLog(@"%.f", _cellHeight );
        }
        
        // 3. 不同类型 cell 的差异高度
        if (self.type == HXLTopicTypePicture) {
            
        } else if(self.type == HXLTopicTypeVideo ) {
            
        } else if(self.type == HXLTopicTypeVoice ) {
            
        }
        
//    }
    NSLog(@"%.f", _cellHeight );
    return _cellHeight;
}

@end

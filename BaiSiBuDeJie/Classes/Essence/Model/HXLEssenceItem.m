//
//  HXLEssenceItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceItem.h"

#import "MJExtension.h"
@interface HXLEssenceItem ()

{
    CGFloat _cellHeight;
    CGRect _pictureFrame;
}
/** 当前累加的高度 */
@property (nonatomic, readwrite,  assign) CGFloat sumHight;

@end

@implementation HXLEssenceItem
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
    return @{ // 调用字典数组时, 本质用自定义类类型的模型数组替换了字典类型的数组, 可以取HXLEssenceCommentItem 类里的属性了;
             @"top_cmt" : @"HXLEssenceCommentItem"
             };
}

// 计算出每个模型的高度
- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        // 1. 基础通用高度
        CGSize text_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 2, MAXFLOAT);
        //        CGSize hotC_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 4, MAXFLOAT);
        // 1.1 帖子描述文字高度
        CGFloat textHight = [self.text boundingRectWithSize:text_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_17} context:nil].size.height;
        
        // cellHeight 的高度累加得到 midView 的 y 坐标
        self.sumHight = containTopView_hight + textHight + essenceMargin_y;
        _cellHeight = self.sumHight;
        
        // 2. 加上点赞 View 的高度
        _cellHeight = _cellHeight + containDingView_hight;
        
        // 3. 由于后期 cell 与 contentView 的 花式变话, 那么就变化对应的整个 cell 的高度增加 15, 原本应该20的;
        _cellHeight = _cellHeight + DIY + essenceMargin_y;
        
        // 4. 有最热评时的高度
        
        // 5. 不同类型 cell 的差异高度
        CGFloat imageW = self.width;
        CGFloat imageH = self.height;
        
        self.isBigPicture = NO;
        
        if (self.type != HXLTopicTypeWord) { // 如果非文字类型
            CGFloat tmpH;
            tmpH = imageH * small_SCREEN_WIDTH  / imageW;
            
            if (imageW > SCREEN_WIDTH) {
                tmpH = imageH * small_SCREEN_WIDTH / imageW;
                
                if (tmpH > SCREEN_HEIGHT * 0.8) {
                    self.isBigPicture = YES;
                    
                    tmpH = SCREEN_HEIGHT * 0.8;
                }
                
            }
            
            _pictureFrame = CGRectMake(0, self.sumHight, small_SCREEN_WIDTH, tmpH);
            
            _cellHeight = _cellHeight + tmpH;
            
        } else if(self.type == HXLTopicTypeVideo ) {
            
        } else if(self.type == HXLTopicTypeVoice ) {
            
        } else { // 段子
            // 只有段子类型, 与点赞 View 无间距, 减掉空隙, 单独返回高度;
            _cellHeight = _cellHeight - essenceMargin_y;
            
            return _cellHeight;
        }
        
        
    }
    
    return _cellHeight;
}


@end

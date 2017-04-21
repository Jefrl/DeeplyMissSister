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
{
    CGFloat _cellHeight;
    CGRect _pictureFrame;
}

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
        CGSize hotC_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 4, MAXFLOAT);
        // 1.1 帖子描述文字高度
        CGFloat textHight = [self.text boundingRectWithSize:text_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_17} context:nil].size.height;
        
        _cellHeight = essenceMargin_y + containTopView_hight + (textHight + essenceMargin_y * 2);
        NSLog(@"%.f", _cellHeight );
        
        // 2. 不同类型 cell 的差异高度
        CGFloat imageW = self.width;
        CGFloat imageH = self.height;
        if (self.type == HXLTopicTypePicture) { // 图片
            if (self.is_gif) { // GIF 图片
                UIImage *image = [UIImage imageWithURLString:self.gifFistFrame];
                imageW = image.size.width;
                imageH = image.size.height;
            }
            
            if (imageW > SCREEN_WIDTH) {
                imageH = imageH * SCREEN_WIDTH / imageW;
                imageW = SCREEN_WIDTH;
            }
            _pictureFrame = CGRectMake(0, _cellHeight - essenceMargin_y, imageW, imageH);
            _cellHeight = _cellHeight + imageH - essenceMargin_y;
        
    } else if(self.type == HXLTopicTypeVideo ) {
        
    } else if(self.type == HXLTopicTypeVoice ) {
        
    }
    // 3. 点赞 midView 的高度
    _cellHeight = _cellHeight + containMidView_hight + cellMargin_y;
    // 4. 有最热评时的高度
    if (self.top_cmt.count != 0) {// 存在热评模型 (至少一条热评)
        self.maxIndex = self.top_cmt.count > showHotCount ? showHotCount - 1 : self.top_cmt.count - 1;
        
        CGFloat __block _tmpHeight = 0;
        [self.top_cmt enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXLEssenceCommentItem *hotItem = obj;
            HXLUser *user = hotItem.user;
            NSString *usernameStr = [NSString stringWithFormat:@"%@:  ", user.username];
            NSString *content = [NSString stringWithFormat:@"%@%@", usernameStr, hotItem.content];
            CGFloat labelHeight = [content boundingRectWithSize:hotC_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_14} context:nil].size.height;
            
            _tmpHeight = essenceMargin_y + labelHeight;
            if (idx == self.maxIndex) *stop = YES;
            
        }];
        _cellHeight = _cellHeight + (_tmpHeight + essenceMargin_y) + essenceMargin_y;
    }
    
}
//    NSLog(@"%.f", _cellHeight );
return _cellHeight;
}

@end

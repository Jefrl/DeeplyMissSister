//
//  HXLEssenceItem.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceItem.h"
#import "HXLEssenceCommentItem.h"

#import "MJExtension.h"
@interface HXLEssenceItem ()
//{
//    CGFloat _cellHeight;
//}

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
    return @{ // 调用字典数组时, 本质用模型数组替换了, 可以取HXLEssenceCommentItem 类里的属性了;
             @"top_cmt" : @"HXLEssenceCommentItem"
             };
}

- (CGFloat)cellHeight
{
    // 最大宽度的限制
    CGSize text_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 2, MAXFLOAT);
    CGSize hotC_maxSize = CGSizeMake(SCREEN_WIDTH - essenceMargin_y * 4, MAXFLOAT);
    CGFloat textHight = [self.text boundingRectWithSize:text_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_17} context:nil].size.height;
    
//    if (_cell.containBottomView.hidden) { // 无热评激活到 contentView 的约束
//        
//        _cell.containConstraint_midToSuperBottom.active = YES;
//        _cell.constraint_midToBottomTop.active = NO;
//        
//        self.cellHight = essenceMargin_y + containTopView_hight + (textHight + essenceMargin_y * 2) + containMidView_hight + (self.containBottomViewHight) + cellMargin_y;
//    } else { // 有热评激活到 midView 到 BottomView的 顶部的约束
//        _cell.containConstraint_midToSuperBottom.active = NO;
//        _cell.constraint_midToBottomTop.active = YES;
    
        // 暂定有三条固定热评;
//        CGFloat firstHot_hight= [self.firstHot_label.text boundingRectWithSize:hotC_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_14} context:nil].size.height;
//        
//        CGFloat secondHot_hight= [_cell.secondHot_label.text boundingRectWithSize:hotC_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_14} context:nil].size.height;
//        
//        CGFloat thirdHot_hight= [_cell.thirdHot_label.text boundingRectWithSize:hotC_maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_14} context:nil].size.height;
//        // 获得底部容易的高度
//        self.containBottomViewHight = firstHot_hight + secondHot_hight + thirdHot_hight + essenceMargin_y * 4;
//        
//        self.cellHight = essenceMargin_y + containTopView_hight + (textHight + essenceMargin_y * 2) + containMidView_hight + (self.containBottomViewHight) + essenceMargin_y + cellMargin_y;
//        
//        if (cell.punCellItem.type == HXLTopicTypePicture) {
//            
//            
//        }
    if (_type == HXLTopicTypePicture) {
        
        
    } else if(_type == HXLTopicTypeVideo ) {
        
    } else if(_type == HXLTopicTypeVoice ) {
        
    }
    
    return _cellHeight;
}



@end

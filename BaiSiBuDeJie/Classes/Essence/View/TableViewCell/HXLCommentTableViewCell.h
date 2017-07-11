//
//  HXLCommentTableViewCell.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/8.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXLEssenceCommentItem;

@interface HXLCommentTableViewCell : UITableViewCell
/** commentItem */
@property (nonatomic, readwrite, strong) HXLEssenceCommentItem *commentItem;
@end

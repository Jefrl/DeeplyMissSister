//
//  HXLCommentViewController.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/7.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXLEssenceItem;

@interface HXLCommentViewController : UIViewController
///** cell */
//@property (nonatomic, readwrite, strong) HXLPunTableViewCell *cell;
/** collectionCellType */
@property (nonatomic, readwrite, assign) NSInteger collectionCellType;
@property (nonatomic, readwrite, strong) HXLEssenceItem *punCellItem;

@end

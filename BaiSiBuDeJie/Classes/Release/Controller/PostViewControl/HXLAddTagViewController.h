//
//  HXLAddTagViewController.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/25.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLAddTagViewController : UIViewController
/** textArray */
@property (nonatomic, readwrite, copy) NSArray *textArray;
/** textBlock */
@property (nonatomic, readwrite, copy) void (^textBlock)(NSArray *tagTextArray);

@end

//
//  HXLDeleteTextField.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/8/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLDeleteTextField : UITextField

/** deleteBlock */
@property (nonatomic, readwrite, copy) void (^deleteBlock)();

@end

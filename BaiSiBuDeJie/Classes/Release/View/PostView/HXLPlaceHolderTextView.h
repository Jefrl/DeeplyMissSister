//
//  HXLPlaceHolderTextView.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/24.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLPlaceHolderTextView : UITextView
/** placeholder */
@property (nonatomic, readwrite, strong) NSString *placeholder;
/** placeholderColor */
@property (nonatomic, readwrite, strong) UIColor *placeholderColor;
@end

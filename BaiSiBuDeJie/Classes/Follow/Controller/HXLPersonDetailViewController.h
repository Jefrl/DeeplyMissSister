//
//  HXLPersonDetailViewController.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/19.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXLFollowUserItem;

@interface HXLPersonDetailViewController : UIViewController
/** backgroundImage */
@property (nonatomic, readwrite, strong) UIImage *backgroundImage;
/** userItem */
@property (nonatomic, readwrite, strong) HXLFollowUserItem *userItem;

@end

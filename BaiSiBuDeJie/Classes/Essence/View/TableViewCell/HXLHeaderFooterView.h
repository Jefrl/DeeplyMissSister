//
//  HXLHeaderFooterView.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/9.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLHeaderFooterView : UITableViewHeaderFooterView
/** header 子控件 */
@property (nonatomic, readwrite, strong) UIView *header;
/** label 子控件 */
@property (nonatomic, readwrite, strong) UILabel *label;

// 从池子中取出合适的 headerFooterView
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;

@end

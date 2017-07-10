//
//  HXLHeaderFooterView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/9.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLHeaderFooterView.h"

@implementation HXLHeaderFooterView
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView
{
    HXLHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cmt_header_reuseID];
    if (headerFooterView == nil) {
        
        headerFooterView = [[self alloc] initWithReuseIdentifier:cmt_header_reuseID];
    }
    
    return headerFooterView;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 创建 headerFooterView
        self.contentView.backgroundColor =  GRAY_PUBLIC_COLOR;
        // 创建内部 header;
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heightForHeaderInSection)];
        header.backgroundColor = WHITE_COLOR;
        [self addSubview:header];
        // 创建内部 label;
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT_13;
        label.frame = CGRectMake(essenceMargin_x, DIY, SCREEN_WIDTH - essenceMargin_x * 2, essenceMargin_x * 2);
        label.textColor = GRAY_COLOR;
        [header addSubview:label];
        
        self.header = header;
        self.label = label;
    }
    
    return self;
}


@end

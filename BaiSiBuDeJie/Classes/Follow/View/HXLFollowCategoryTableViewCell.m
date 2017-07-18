//
//  HXLFollowCategoryTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLFollowCategoryTableViewCell.h"
#import "HXLFollowCategoryItem.h"

@interface HXLFollowCategoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@end

@implementation HXLFollowCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 让 cell 的选中风格变成 无风格后, 内部子控件才不会出现高亮
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCategoryItem:(HXLFollowCategoryItem *)categoryItem
{
    _categoryItem = categoryItem;
    
    self.categoryLabel.text = categoryItem.name;
}

// 监听 cell 的被选中情况!
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectView.hidden = !selected;
    self.categoryLabel.textColor = selected ? RED_COLOR : BLACK_COLOR;
}

@end

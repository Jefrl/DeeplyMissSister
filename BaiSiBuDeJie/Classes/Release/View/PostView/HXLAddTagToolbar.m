//
//  HXLAddTagToolbar.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/25.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLAddTagToolbar.h"
#import "HXLAddTagViewController.h"
#import "HXLNavigationController.h"

@interface HXLAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation HXLAddTagToolbar
+ (instancetype)toolbar
{
    return [self loadViewFormXib:0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //添加加号按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"]  forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addTagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:btn];
    btn.x = essenceMargin_x;
    btn.size = btn.currentImage.size;
    
}

- (void)addTagButtonClick:(UIButton *)sender
{
    HXLAddTagViewController *tagVC = [[HXLAddTagViewController alloc] init];
    UIViewController *punVC = KEYWINDOW.rootViewController;
    // 拿到被根控制器 presented 出来的那个导航控制器, 然后用这个 nav 来 push;
    HXLNavigationController *selectedNav = (HXLNavigationController *)punVC.presentedViewController;
    [selectedNav pushViewController:tagVC animated:YES];
}



@end

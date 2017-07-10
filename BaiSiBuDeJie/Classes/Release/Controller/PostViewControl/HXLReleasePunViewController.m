//
//  HXLReleasePunViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/6.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLReleasePunViewController.h"
#import "HXLPostButton.h"
#import "HXLPunView.h"

@interface HXLReleasePunViewController ()
/** postBtn */
@property (nonatomic, weak) HXLPostButton *postBtn;

@end

@implementation HXLReleasePunViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBRandomColor;
    // 设置导航条
    [self setupPostPunsNavigationBar];
    HXLPunView *voatView = [HXLPunView loadViewFormXib:0];
    
    voatView.frame = CGRectMake(0, SCREEN_HEIGHT - 49*2, SCREEN_WIDTH, 49);
    [self.view addSubview:voatView];

}


/** 设置导航条 */
- (void)setupPostPunsNavigationBar {
    self.navigationItem.title = @"发表文字";
    // 1. 导航控制器的设置页面了, 非导航的根控制器了, 需要侧滑 pop 甚至全屏侧滑, 所以最好不自定义 barButtonItem; 保留导航控制器的手势代理; 就有系统自带的侧滑;
    // (2. 否则你自定义了 Item 按钮, 你就需要在 push完后 跟 pop 完页面后在监听方法didShowViewController 恰当的清空手势代理设为nil 跟恢复手势按钮)
    // < 3. 否则, 就干脆做一个自定义的全屏侧滑(推荐, 尤其是本身要求全屏侧滑的时候, 同时又兼容了自定义的好处)>
    // 这里我用方法3;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemTitle:@"取消" titltColor:WHITE_COLOR  titleSelectedColor:GRAY_COLOR fontSize:FONT_15 target:self action:@selector(cancelItemClick:) contentEdgeInsets:UIEdgeInsetsZero forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    // 右侧发表按钮
    HXLPostButton *postBtn = [HXLPostButton buttonWithType:UIButtonTypeCustom];
    [postBtn setTitle:@"发表" forState:UIControlStateNormal];
    [postBtn setImage:[UIImage imageNamed:@"1-1"] forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(postPunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [postBtn sizeToFit];
    _postBtn = postBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [_postBtn setImage:[UIImage imageNamed:@"Snip20170307_1"] forState:UIControlStateNormal];
}

/** postPunBtnClick */
- (void)postPunBtnClick:(UIButton *)postPunBtn {
    NSLog(@"");
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/** cancelItemClick */
- (void)cancelItemClick:(UIButton *)cancelItem {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

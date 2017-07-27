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
#import "HXLPlaceHolderTextView.h"
#import "HXLAddTagToolbar.h"

@interface HXLReleasePunViewController ()<UITextViewDelegate>
/** postBtn */
@property (nonatomic, weak) HXLPostButton *postBtn;
/** HXLPlaceHolderTextView *placeholderTextView */
@property (nonatomic, readwrite, weak) HXLPlaceHolderTextView *placeholderTextView;

@end

@implementation HXLReleasePunViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupPostPunsNavigationBar];
    // 设置 textView
    [self setupTextView];
    // 设置 addToolbar
    [self setupAddToolbar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.placeholderTextView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.placeholderTextView resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.hasText) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

#pragma mark - 设置 toolbar
- (void)setupAddToolbar
{
    HXLAddTagToolbar *toolbar = [HXLAddTagToolbar toolbar];
    self.placeholderTextView.inputAccessoryView = toolbar;
}

#pragma mark - 设置 textView
- (void)setupTextView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    HXLPlaceHolderTextView *placeholderTextView = [[HXLPlaceHolderTextView alloc] init];
    self.placeholderTextView = placeholderTextView;
    placeholderTextView.delegate = self;
    
    placeholderTextView.textColor = BLACK_COLOR;
    placeholderTextView.font = FONT_15;
    placeholderTextView.placeholderColor = GRAY_COLOR;
    placeholderTextView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    
    placeholderTextView.frame = self.view.bounds;
    placeholderTextView.y = NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:placeholderTextView];
}

#pragma mark - 设置导航栏
- (void)setupPostPunsNavigationBar {
    self.navigationItem.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemTitle:@"取消" titltColor:WHITE_COLOR  titleSelectedColor:GRAY_COLOR fontSize:FONT_15 target:self action:@selector(cancelItemClick:) contentEdgeInsets:UIEdgeInsetsZero forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
    
    // 右侧发表按钮
    HXLPostButton *postBtn = [HXLPostButton buttonWithType:UIButtonTypeCustom];
    [postBtn setTitle:@"发表" forState:UIControlStateNormal];
    [postBtn setImage:[UIImage imageNamed:@"post-tag-bg"] forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(postPunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [postBtn sizeToFit];
    _postBtn = postBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)postPunBtnClick:(UIButton *)postPunBtn {
    NSLog(@"postPunBtnClick");
    [self.view endEditing:YES];
}

- (void)cancelItemClick:(UIButton *)cancelItem {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}




@end

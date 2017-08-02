//
//  HXLLoginRegisterViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/17.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLLoginRegisterViewController.h"

@interface HXLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegister;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeft;


@end

@implementation HXLLoginRegisterViewController
- (void)viewDidLoad
{
    [self.loginRegister setTitle:@"点击注册" forState:UIControlStateNormal];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)closedBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginRegisterBtnClick:(UIButton *)sender {
 
    [self.view endEditing:YES];
    if ([sender.titleLabel.text isEqualToString:@"点击注册"]) {
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal];
        self.loginLeft.constant = - SCREEN_WIDTH;
        self.registerLeft.constant = 0;
        
    } else {
        [sender setTitle:@"点击注册" forState:UIControlStateNormal];
        self.loginLeft.constant = 0;
        self.registerLeft.constant = SCREEN_WIDTH;
        
    }
    
    [UIView animateWithDuration:0.41 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

@end

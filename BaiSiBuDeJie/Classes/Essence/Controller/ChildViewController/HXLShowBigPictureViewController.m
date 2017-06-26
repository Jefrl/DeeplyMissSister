//
//  HXLShowBigPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/6/26.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLShowBigPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "HXLEssenceItem.h"
#import "SVProgressHUD.h"


@interface HXLShowBigPictureViewController ()
/** 滚动视图 */
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/** imageView */
@property (nonatomic, readwrite, strong) UIImageView *imageView;

@end

@implementation HXLShowBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // imageView 的设置
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    
    // 开启 imageView 的交互, 并添点击手势;
    imageView.userInteractionEnabled = YES;
    UIGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick:)];
    [imageView addGestureRecognizer:tapGes];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_punCellItem.small_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        
    }];
    
    CGFloat width = _punCellItem.pictureFrame.size.width;
    CGFloat height = _punCellItem.height * width / _punCellItem.width;
    imageView.frame = CGRectMake(0, 0, width, height);
    
    // scrollView 的设置;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = imageView.size;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 添加返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"show_image_back_icon_click"] forState:UIControlStateHighlighted];
    backBtn.originX = backBtn.currentImage.size.width;
    backBtn.originY = backBtn.currentImage.size.width;
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加保存到相册按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setImage:[UIImage imageNamed:@"big_image_save"] forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:@"big_image_save_click"] forState:UIControlStateHighlighted];
    saveBtn.originX = backBtn.currentImage.size.height;
    saveBtn.originY = SCREEN_HEIGHT - (backBtn.currentImage.size.height * 2);
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 统一添加子控件
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:imageView];
    [self.view addSubview:backBtn];
}

#pragma - 业务逻辑
- (void)saveBtnClick:(UIButton *)btn {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
    
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error == nil) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
}

- (void)backBtnClick:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end

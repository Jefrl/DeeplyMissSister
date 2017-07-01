//
//  HXLShowBigPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/6/26.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLShowBigPictureViewController.h"
#import "HXLEssenceItem.h"
#import "SVProgressHUD.h"
#import "FLAnimatedImageView+WebCache.h"


@interface HXLShowBigPictureViewController ()
/** 滚动视图 */
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/** 大图 View */
@property (nonatomic, readwrite, strong) FLAnimatedImageView *imageView;
/** 底部 View */
@property (nonatomic, readwrite, strong) UIImageView *bottomV;
/** 返回按钮 */
@property (nonatomic, readwrite, strong) UIButton *backBtn;
/** 保存按钮 */
@property (nonatomic, readwrite, strong) UIButton *saveBtn;


@end

@implementation HXLShowBigPictureViewController
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        // 添加保存到相册按钮
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setImage:[UIImage imageNamed:@"big_image_save"] forState:UIControlStateNormal];
        [saveBtn setImage:[UIImage imageNamed:@"big_image_save_click"] forState:UIControlStateHighlighted];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn sizeToFit];
        saveBtn.originX = essenceMargin_x;
        saveBtn.centerY = self.bottomV.height * 0.5;
        [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _saveBtn = saveBtn;
    }
    
    return _saveBtn;
}

// 添加返回按钮
- (UIButton *)backBtn
{
    if (!_backBtn) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"show_image_back_icon_click"] forState:UIControlStateHighlighted];
        [backBtn sizeToFit];
        backBtn.originX = backBtn.currentImage.size.width * 0.5;
        backBtn.originY = backBtn.originX;
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _backBtn = backBtn;
    }
    
    return _backBtn;
}

- (UIImageView *)bottomV
{
    if (!_bottomV) {
        // 添加底部阴影 bottomV
        _bottomV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"see-big-picture-background"]];
        _bottomV.userInteractionEnabled = YES;
        
        _bottomV.frame = CGRectMake(0, SCREEN_HEIGHT - _bottomV.image.size.height, SCREEN_WIDTH, _bottomV.image.size.height);
    }
    
    return _bottomV;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        // scrollView 的设置;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;

        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.bounces = NO;
        UIGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick:)];
        [_scrollView addGestureRecognizer:tapGes];
    }
    
    return _scrollView;
}

- (FLAnimatedImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[FLAnimatedImageView alloc] init];
        // 开启 imageView 的交互, 并添点击手势;
        _imageView.userInteractionEnabled = YES;
        
        // imageView 加载图片
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_punCellItem.small_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
        
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = _punCellItem.height * width / _punCellItem.width;
        if (height <= SCREEN_HEIGHT) {
            _imageView.size = CGSizeMake(width, height);
            _imageView.centerX = self.view.centerX;
            _imageView.centerY = self.view.centerY;
        } else {
            
            _imageView.frame = CGRectMake(0, 0, width, height);
        }

        [self.scrollView addSubview:_imageView];
        self.scrollView.contentSize = _imageView.size;
    }
    
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 基础设置
    [self setup];
}

- (void)setup
{
    // 统一添加子控件
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.bottomV];
    [self.view addSubview:self.backBtn];
    [self.bottomV addSubview:self.saveBtn];
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
        [SVProgressHUD showSuccessWithStatus:@"已保存到相册"];
        [SVProgressHUD dismissWithDelay:0.5];
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:0.5];
    }
}

- (void)backBtnClick:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end

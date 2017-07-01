//
//  HXLPictureTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPictureView.h"
#import "HXLEssenceItem.h"
#import "HXLShowBigPictureViewController.h"
#import "FLAnimatedImageView+WebCache.h"

#import "HXLProgressView.h"

@interface HXLPictureView ()

/** 占位图片 */
@property (weak, nonatomic) IBOutlet UIImageView *placeholdImageView;
/** small_imageView */
@property (nonatomic, weak) IBOutlet FLAnimatedImageView *smallImageView;
/** gif 标识logo */
@property (nonatomic, weak) IBOutlet UIImageView *gifImageView;
/** 失败加载的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *loadError_imageView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *loadSuccess_imageView;
/** progressView */
@property (nonatomic, strong) IBOutlet HXLProgressView *progressView;


@end

@implementation HXLPictureView
- (IBAction)seeBigPictureClick:(UIButton *)sender {
    
    HXLShowBigPictureViewController *showBigPicVC = [[HXLShowBigPictureViewController alloc] init];
    showBigPicVC.punCellItem = self.punCellItem;
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [rootVC presentViewController:showBigPicVC animated:YES completion:nil];
    
}

#pragma mark - lazy zone

#pragma mark - init zone
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.smallImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPictureClick:)];
    [self addGestureRecognizer:tapGes];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.smallImageView.frame = self.punCellItem.pictureFrame;
    self.smallImageView.y = 0;
}

#pragma mark - setter zone
- (void)setPunCellItem:(HXLEssenceItem *)punCellItem
{
    _punCellItem = punCellItem;
    // 初始化加载进程 View
    self.gifImageView.hidden = NO;
    self.progressView.hidden = NO;
    self.placeholdImageView.hidden = NO;
    
//    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
//    [self.progressView setProgress:punCellItem.currentProgress animated:NO];
    
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:_punCellItem.small_image] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

        NSLog(@"%@, %ld, %ld, %.01f", @"progress", receivedSize, expectedSize, 1.00 * receivedSize/expectedSize);
        
        // 计算进度值
        punCellItem.currentProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:punCellItem.currentProgress animated:NO];
       
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 进来就要隐藏;
        self.progressView.hidden = YES;
        
        if (error) { // 网络加载失败就, 显示加载失败的图片;
            self.placeholdImageView.hidden = YES;
            self.smallImageView.hidden = YES;
            self.loadError_imageView.hidden = NO;
            
            return ;
        }
        
        self.smallImageView.hidden = NO;
        self.loadError_imageView.hidden = YES;
        
//         如果是大图片, 才需要进行绘图处理
        if (_punCellItem.isBigPicture == NO) return;
        
        self.seeBigButton.hidden = NO;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(_punCellItem.pictureFrame.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = _punCellItem.pictureFrame.size.width;
        CGFloat height = image.size.height * width / image.size.width;
        
        [image drawInRect:CGRectMake(0, 0, width, height)];
        // 获得图片
        self.smallImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        self.size = image.size;
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
        
    }];
    
    if (_punCellItem.is_gif) {
        
        self.seeBigButton.hidden = YES;
        self.gifImageView.hidden = NO;
    }
    
}


@end

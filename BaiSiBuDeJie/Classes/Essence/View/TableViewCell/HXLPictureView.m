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
/** progressView */
@property (nonatomic, strong) IBOutlet HXLProgressView *progressView;


@end

@implementation HXLPictureView
- (IBAction)seeBigPictureClick:(UIButton *)sender {
    
    HXLShowBigPictureViewController *showBigPicVC = [[HXLShowBigPictureViewController alloc] init];
    showBigPicVC.punCellItem = self.punCellItem;
    
    UIViewController *rootVC = KEYWINDOW.rootViewController;
    
    [rootVC presentViewController:showBigPicVC animated:YES completion:nil];
    
}

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
    self.seeBigButton.hidden = YES;
    self.gifImageView.hidden = YES;
    
    _punCellItem = punCellItem;

    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:punCellItem.currentProgress animated:NO];
    
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:_punCellItem.small_image] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        // 进来就要显示;
        self.progressView.hidden = NO;
        
//        NSLog(@"%@, %ld, %ld, %.01f", @"progress", receivedSize, expectedSize, 1.00 * receivedSize/expectedSize);
        
        // 计算进度值
        punCellItem.currentProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:punCellItem.currentProgress animated:NO];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", punCellItem.currentProgress * 100];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 进来就要隐藏;
        self.progressView.hidden = YES;
        
        if (error) { // 网络加载失败就, 显示加载失败的图片;
            NSLog(@"%@", error);
            
            self.placeholdImageView.hidden = YES;
            self.loadError_imageView.hidden = NO;
            
            return ;
        }
        
//         如果是大图片, 才需要进行绘图处理
        if (_punCellItem.isBigPicture == NO) return;
        
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
    
    if (_punCellItem.isBigPicture) {
        self.seeBigButton.hidden = NO;
    }
    
//    [self validateGif];
    if (_punCellItem.is_gif) {
        self.gifImageView.hidden = NO;
    }
    
}


/**
// 是否开启图片真实格式判断;
// 但是有点耗性能啊, 如果开子线程, 后期刷新, 那么意义不大, 控件突然出现的感觉;
- (void)validateGif
{
    _punCellItem.isRealGif = NO;
    
    NSData *dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:_punCellItem.small_image]];
    NSString *imageType = [self contentTypeForImageData:dataImage];
    
    NSLog(@"%@", imageType);
    if ([imageType isEqualToString:@"gif"]) {
        //  这个属性后台不处理, 标记的 GIF 有假的;
        _punCellItem.isRealGif = YES;
        _punCellItem.is_gif = YES;
        
        [self performSelectorOnMainThread:@selector(refresh) withObject:nil waitUntilDone:YES];
    }
}

- (void)refresh
{
    LogTest;
    UITabBarController *tabC = (UITabBarController *)KEYWINDOW.rootViewController;
    UINavigationController *nav = tabC.selectedViewController;
    UIViewController *essVC = nav.topViewController;
    UITableViewController *tabVC = essVC.childViewControllers.firstObject;
    
    NSLog(@"%@---%@---%@---%@", tabC, nav, essVC, tabVC);
    
//    [tabVC.tableView reloadData];
}

*/

@end

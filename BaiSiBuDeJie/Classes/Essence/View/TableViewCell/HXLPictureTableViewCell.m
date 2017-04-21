//
//  HXLPictureTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPictureTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
#import "HXLEssenceItem.h"

@interface HXLPictureTableViewCell ()

/** 占位图片 */
@property (weak, nonatomic) IBOutlet UIImageView *placeholdImageView;
/** small_imageView */
@property (nonatomic, weak) IBOutlet UIImageView *smallImageView;
/** gifView */
@property (nonatomic, weak) IBOutlet UIImageView *gifImageView;
/** progressView */
@property (nonatomic, weak) IBOutlet UIView *progressView;
/** 失败加载的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *loadError_imageView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation HXLPictureTableViewCell

- (void)setPunCellItem:(HXLEssenceItem *)punCellItem
{
    _punCellItem = punCellItem;
    self.gifImageView.hidden = YES;
    // 转圈加载标志
//    [_progressView setProgress:]
    
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:_punCellItem.small_image] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
//        if (error) { // 网络加载失败就, 显示加载失败的图片;
//            self.smallImageView.hidden = YES;
//            self.loadError_imageView.hidden = NO;
//            return ;
//        }
//        
//        // 如果是大图片, 才需要进行绘图处理
//        if (_punCellItem.isBigPicture == NO) return;
//        
//        // 开启图形上下文
//        UIGraphicsBeginImageContextWithOptions(_punCellItem.pictureFrame.size, YES, 0.0);
//        
//        // 将下载完的image对象绘制到图形上下文
//        CGFloat width = _punCellItem.pictureFrame.size.width;
//        CGFloat height = width * image.size.height / image.size.width;
//        [image drawInRect:CGRectMake(0, 0, width, height)];
//        
//        // 获得图片
//        self.smallImageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        
//        // 结束图形上下文
//        UIGraphicsEndImageContext();
//        
    }];
    
    if (_punCellItem.is_gif) {
        self.gifImageView.hidden = NO;
    }
    
}


@end

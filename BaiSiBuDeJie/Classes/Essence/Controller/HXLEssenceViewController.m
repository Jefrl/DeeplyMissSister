//
//  HXLEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLEssenceViewController.h"
#import "HXLAllTableVC.h"
#import "HXLVideoTableVC.h"
#import "HXLPictureTableVC.h"
#import "HXLPunTableVC.h"
#import "HXLVoiceTableVC.h"
#import "HXLHeadlineView.h"

@interface HXLEssenceViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/** headlineVC_arr 头标题控制器数组 */
@property (nonatomic, strong) NSArray *headlineVC_arr;

@end

@implementation HXLEssenceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBRandomColor;
    // 界面搭建
    [self setup];
}

/** 状态栏的设置 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/** UI 界面的搭建 */
NSString * const reuseID = @"collectionCell";
- (void)setup {
    // 禁止系统调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 导航栏的搭建
    [self setupNavigationBar];
    // 添加子控制器
    [self setupChildVC];
    
    // 搭建 contentView
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewFlowLayout];
    //
    collectionViewFlowLayout.minimumLineSpacing = 0;
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.itemSize = SCREEN_BOUNDS.size;
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = BROWN_COLOR;
    //
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    // 添加加到精华 View 上注意添加顺序
    [self.view addSubview:contentView];
    
    // 搭建 headlineView
    [self setupHeadlineView: _headlineVC_arr];
    
}

#pragma mark - 02
/** 搭建  */
/** 代理方法 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _headlineVC_arr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    UIViewController *childVC = _headlineVC_arr[indexPath.row];
    childVC.view.backgroundColor = RGBRandomColor;
    [cell.contentView addSubview:childVC.view];
    
    return cell;
}


/** 搭建 headlineView */
- (void)setupHeadlineView:(NSArray *)array {
    
    HXLHeadlineView *headlineView = [[HXLHeadlineView alloc] setupHeadlineViewWithArray:_headlineVC_arr];
    [self.view addSubview:headlineView];
}

/** 添加essenceVC 的子控制器 */
- (void)setupChildVC {
    
    HXLAllTableVC *allTableVC = [[HXLAllTableVC alloc] init];
    allTableVC.title = @"全部";
    HXLVideoTableVC *videoTableVC = [[HXLVideoTableVC alloc] init];
    videoTableVC.title = @"视频";
    HXLPictureTableVC *picTableVC = [[HXLPictureTableVC alloc] init];
    picTableVC.title = @"图片";
    HXLPunTableVC *punTableVC = [[HXLPunTableVC alloc] init];
    punTableVC.title = @"段子";
    HXLVoiceTableVC *voiceTableVC = [[HXLVoiceTableVC alloc] init];
    voiceTableVC.title = @"声音";
    
    [self addChildViewController:allTableVC];
    [self addChildViewController:videoTableVC];
    [self addChildViewController:picTableVC];
    [self addChildViewController:punTableVC];
    [self addChildViewController:voiceTableVC];
    NSArray *array = @[allTableVC, videoTableVC, picTableVC, punTableVC, voiceTableVC];
    // 保存到数组
    _headlineVC_arr = array;
}

#pragma mark - 01
/** 导航栏的搭建 */
- (void)setupNavigationBar {
    
    // 设置导航栏的 titleView
    UIImage *imageOrigin = [UIImage imageNamed:@"MainTitle"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:imageOrigin];
    [bgImageView sizeToFit];
    self.navigationItem.titleView = bgImageView;
    
    // 设置导航栏左&右 Item
    UIImage *imageNormal = [UIImage imageNamed:@"nav_item_game_icon"];
    UIImage *imageHighlighted = [UIImage imageNamed:@"nav_item_game_click_icon"];
    
    UIImage *R_imageNormal = [UIImage imageNamed:@"navigationButtonRandomN"];
    UIImage *R_imageHighlighted = [UIImage imageNamed:@"navigationButtonRandomClickN"];
    
    UIBarButtonItem *leftBarBtnItem = [UIBarButtonItem barButtonItemImage:imageNormal selectedImage:imageHighlighted addTarget:self action:@selector(leftBarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtnItem = [UIBarButtonItem barButtonItemImage:R_imageNormal selectedImage:R_imageHighlighted addTarget:self action:@selector(rightBarBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

/** 导航栏左&右侧的点击事件 */
- (void)leftBarBtnItemClick:(UIButton *)btn {
    
    NSLog(@"左侧按钮被点击了");
}

- (void)rightBarBtnItemClick:(UIButton *)btn {
    NSLog(@"右侧 Item 被点击了");
}

@end

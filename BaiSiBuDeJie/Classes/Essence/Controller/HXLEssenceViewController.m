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

#import "HXLTabBarController.h"
#import "MJRefresh.h"

@interface HXLEssenceViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/** headlineVC_arr 头标题控制器数组 */
@property (nonatomic, strong) NSArray *headlineVC_arr;
/** contentCollectionView */
@property (nonatomic, weak) UICollectionView *contentCollectionView;
/** headlineView */
@property (nonatomic, weak) HXLHeadlineView *headlineView;
/** ob */
@property (nonatomic, strong) NSNotificationCenter *ob;
/** selectedBtn */
@property (nonatomic, strong) UIButton *selectedBtn;



@end

@implementation HXLEssenceViewController

NSString * const reuseID = @"collectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 界面搭建
    [self setup];
    
    // 注册通知
    [self observeNoti];

}

- (void)observeNoti
{
    self.ob = [[NSNotificationCenter defaultCenter] addObserverForName:@"btn" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGFloat offsetX = SCREEN_WIDTH * _headlineView.selectedBtnIndex;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [_contentCollectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
        } completion:nil];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"");
}

/** 状态栏的设置 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/** UI 界面的搭建 */
- (void)setup {
    
    // 禁止系统调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 导航栏的搭建
    [self setupNavigationBar];
    // 添加子控制器
    [self setupChildVC];
    // 搭建 contentView
    [self setupContentCollectionView];
    // 搭建 headlineView
    [self setupHeadlineView: _headlineVC_arr];
    
}

#pragma mark - 02
/** 搭建contentCollectionView  */
- (void)setupContentCollectionView {
    // collectionViewFlowLayout 的创建与设置
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.minimumLineSpacing = 0;
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.itemSize = SCREEN_BOUNDS.size;
    // contentCollectionView 的创建与设置
    UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewFlowLayout];
    contentCollectionView.frame = self.view.bounds;
    contentCollectionView.backgroundColor = BROWN_COLOR; // 调试棕色
    contentCollectionView.pagingEnabled = YES;
    contentCollectionView.bounces = NO;
    // 代理与数据源
    contentCollectionView.delegate = self;
    contentCollectionView.dataSource = self;
    // 注册 UICollectionViewCell ;
    [contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    
    [self.view addSubview:contentCollectionView];
    _contentCollectionView = contentCollectionView;
}

/** 代理方法 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _headlineVC_arr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    // 添加到cell 之前, 要将重用的cell 的之前的内容移除
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 每一个tableView 添加到collectionViewCell 的contentView 上;
    UITableViewController *childVC = _headlineVC_arr[indexPath.row];
//    childVC.tableView.backgroundColor = LIGHTGRAY_COLOR; // 调试灰色
    [cell.contentView addSubview:childVC.tableView];
    
    return cell;
}

/** 滚动停止更新 underline */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSLog(@"%ld", i);
    [_headlineView moveUnderlineBtn:_headlineView.headlineBtn_arr[i]];
}


/** 搭建 headlineView */
- (void)setupHeadlineView:(NSArray *)array {
    
    HXLHeadlineView *headlineView = [[HXLHeadlineView alloc] initWithHeadlineViewWithArray:_headlineVC_arr];
    _headlineView = headlineView;
//    headlineView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, HeadlineView_height);
    [self.view addSubview:headlineView];
}

/** 添加essenceVC 的子控制器 */
- (void)setupChildVC {
    
    HXLAllTableVC *allTableVC = [[HXLAllTableVC alloc] init];
    allTableVC.title = @"全部";
    HXLVideoTableVC *videoTableVC = [[HXLVideoTableVC alloc] init];
    videoTableVC.title = @"视频视频视频";
    HXLPictureTableVC *picTableVC = [[HXLPictureTableVC alloc] init];
    picTableVC.title = @"图片图片";
    HXLPunTableVC *punTableVC = [[HXLPunTableVC alloc] init];
    punTableVC.title = @"段子段子段子段子";
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

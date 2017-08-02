//
//  HXLReleaseViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/2/28.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLReleaseViewController.h"
#import "HXLReleaseButton.h"
#import "POP.h"
#import "HXLReleasePunViewController.h"
#import "HXLNavigationController.h"
#import "HXLTabBarController.h"

@interface HXLReleaseViewController ()
/** labelArray */
@property (nonatomic, strong) NSArray *labelArray;
/** 动画时间数组 */
@property (nonatomic, strong) NSArray *timeArray;
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray * fiveBtnArray;


@end

@implementation HXLReleaseViewController

- (NSMutableArray *)fiveBtnArray {
    if (!_fiveBtnArray) {
        _fiveBtnArray = [NSMutableArray array];
    }
    return _fiveBtnArray;
}

- (NSArray *)timeArray {
    if (!_timeArray) {
        
        CGFloat unitInterval = 0.1;
        NSArray *timeArray = @[
                               @(2 * unitInterval), //发视频
                               @(4 * unitInterval), //发图片
                               @(3 * unitInterval), //发段子
                               @(0 * unitInterval), //发声音
                               @(1 * unitInterval), //发链接
                               @(5 * unitInterval)  //发口号标题;
                               ];
        _timeArray = timeArray;
    }
    
    return _timeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];

}

/** UI 界面的搭建 */
- (void)setup {
    
    // 开始动画取消交互
    self.view.userInteractionEnabled = NO;
    
    // view 的背景图设置
    UIImageView *bg_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shareBottomBackground"]];
    bg_imageView.frame = self.view.bounds;
    [self.view addSubview:bg_imageView];
    
    // 所有按钮的搭建
    [self setupAllButton];
    
    // 口号的搭建
    [self setupSlogan];
    
}

/** 口号的搭建 */
- (void)setupSlogan {
    // 口号标题的创建
    UIImageView *appSloganImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloganEnd_centerY = SCREEN_HEIGHT * 0.17;
    CGFloat slogan_X = SCREEN_WIDTH * 0.2;
    CGFloat sloganStart_centerY = - sloganEnd_centerY;
    
    appSloganImageView.center = CGPointMake(slogan_X , sloganStart_centerY);
    // 保存最后动画者
    [self.fiveBtnArray addObject:appSloganImageView];
    [self.view addSubview:appSloganImageView];
    // 口号标题的 pop 动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(slogan_X, sloganStart_centerY, slogan_X * 3, 25)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(slogan_X, sloganEnd_centerY, slogan_X * 3, 25)];
    anim.springSpeed = HXLSPRING_SPEED;
    anim.springBounciness = HXLSPRING_SPEEDBOUNDCE;
    anim.beginTime = CACurrentMediaTime() + [self.timeArray[5] doubleValue];
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        NSLog(@"动画完成");
        // 开启交互;
        self.view.userInteractionEnabled = YES;
    }];
    
    [appSloganImageView pop_addAnimation:anim forKey:nil];
}

/** 所有按钮的搭建 */
- (void)setupAllButton {
    
    // 取消按钮的创建
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"取消" forState: UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.frame = CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
    [backBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    // 5个按钮的创建
    NSArray *titleLabelArray = @[@"发视频", @"发图片", @"发段子", @"发声音", @"发链接"];
    _labelArray = titleLabelArray;
    NSArray *imageNameArray = @[[UIImage imageNamed:@"publish-video"], [UIImage imageNamed:@"publish-picture"], [UIImage imageNamed:@"publish-text"], [UIImage imageNamed:@"publish-audio"], [UIImage imageNamed:@"publish-link"]];
    
    NSInteger btnCount = titleLabelArray.count;
    NSInteger colCountMax = 3;
    CGFloat spaceY = B_spaceX;
    CGFloat btnW = (SCREEN_WIDTH - (colCountMax - 1) * A_spaceX - 2 * B_spaceX) / colCountMax;
    CGFloat btnH = btnW * 1.1;
    for (int i = 0; i < btnCount; i++) {
        
        UIButton *btn = [HXLReleaseButton buttonWithType:UIButtonTypeCustom];
        btn.y = - btnH;
        [btn setImage:imageNameArray[i] forState:UIControlStateNormal];
        [btn setTitle:titleLabelArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        // 保存按钮
        [self.fiveBtnArray addObject:btn];
        [self.view addSubview:btn];
        
        NSInteger colIndex = i % colCountMax;
        NSInteger rowIndex = i / colCountMax;
        CGFloat btnX = (btnW + A_spaceX + B_spaceX) * colIndex;
        CGFloat btnEndY = (0.33 * SCREEN_HEIGHT) + (btnH + spaceY) * rowIndex;
        CGFloat btnStartY = - btnH;
        
        // btn 的 pop 动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnStartY, btnW, btnH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        animation.springSpeed = HXLSPRING_SPEED;
        animation.springBounciness = HXLSPRING_SPEEDBOUNDCE;
        animation.beginTime = CACurrentMediaTime() + [self.timeArray[i] doubleValue];
        [btn pop_addAnimation:animation forKey:nil];
        
    }
}



/** 五个按钮的点击事件 */
- (void)btnClick:(UIButton *)btn {
    NSInteger num = btn.tag;
    if (num == ButtonTypePostVideo) { // 视频
        NSLog(@"%@", _labelArray[num]);
        [self btnViewDisappearWithPop:nil];
    } else if (num == ButtonTypePostPicture) { // 图片
        NSLog(@"%@", _labelArray[num]);
        [self btnViewDisappearWithPop:nil];
    } else if (num == ButtonTypePostPun) { // 段子
        NSLog(@"%@", _labelArray[num]);
        
        // 定义一个 block, 动画完成后执行
        void (^complete_block)() = ^(){
            
            // 通过 APP 类的主窗口获取, 当前窗口的根控制器;
            UIWindow *keywidow = [UIApplication sharedApplication].keyWindow;
            UITabBarController *tabBarC = (UITabBarController *)keywidow.rootViewController;
            HXLReleasePunViewController *releasePunVC = [[HXLReleasePunViewController alloc] init];
            // 要注意位置, push 之前设置隐藏;
            [tabBarC.selectedViewController pushViewController:releasePunVC animated:YES];
        };
        
        // 动画
        [self btnViewDisappearWithPop:complete_block];
        
    } else if (num == ButtonTypePostVoice) { // 声音
        NSLog(@"%@", _labelArray[num]);
        [self btnViewDisappearWithPop:nil];
    } else if (num == ButtonTypePostLink) { // 链接
        NSLog(@"%@", _labelArray[num]);
        [self btnViewDisappearWithPop:nil];
    }
}

/** 点击屏幕 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self btnViewDisappearWithPop:nil];
}

/** 取消按钮的点击 */
- (void)cancelBtnClick:(UIButton *)cancelbtn {
    // 让6个动画执行完
    [self btnViewDisappearWithPop:nil];
}

/** 让6个动画执行完消失 */


- (void)btnViewDisappearWithPop:(void (^)())complete_block {
    // 禁止互交
    self.view.userInteractionEnabled = NO;
    
    NSInteger totalCount = self.fiveBtnArray.count;
    for (int i = 0; i < totalCount; i++) {
        UIView *btnView = self.fiveBtnArray[i];
        
        CGFloat btnX = btnView.x;
        CGFloat btnStartY = btnView.y;
        CGFloat btnEndY = btnStartY + SCREEN_HEIGHT;
        CGFloat btnW = btnView.width;
        CGFloat btnH = btnView.height;
        
        // btnView 的 pop 动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnStartY, btnW, btnH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        animation.springSpeed = HXLSPRING_SPEED;
        animation.springBounciness = HXLSPRING_SPEEDBOUNDCE;
        animation.beginTime = CACurrentMediaTime() + [self.timeArray[i] doubleValue];
        
        HXL_WEAKSELF; // 弱指向
        if (i == totalCount - 1) { // 最后一个动画了
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                HXL_STRONGSELF;
                
                // 有没有循环引用呢, 代码块执行完毕, 这里为局部变量, 会释放;
                [strongSelf dismissViewControllerAnimated:NO completion:nil];
                
                // block 有值才调用
                !complete_block ?  : complete_block() ;
            }];
        }
        
        [btnView pop_addAnimation:animation forKey:nil];
        
    }

}

@end

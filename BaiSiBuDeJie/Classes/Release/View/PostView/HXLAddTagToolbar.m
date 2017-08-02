//
//  HXLAddTagToolbar.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/25.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLAddTagToolbar.h"
#import "HXLAddTagViewController.h"
#import "HXLNavigationController.h"

@interface HXLAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 加号按钮 */
@property (nonatomic, readwrite, weak) UIButton *plusBtn;
/** labelArray */
@property (nonatomic, readwrite, strong) NSMutableArray *labelArrayM;
/** 标签标题数组 */
@property (nonatomic, strong) NSMutableArray * textArrayM;

@end

@implementation HXLAddTagToolbar

#pragma mark - 懒加载
- (NSMutableArray *)textArrayM
{
    if (!_textArrayM) {
        _textArrayM = [NSMutableArray array];
    }
    return _textArrayM;
}

- (NSMutableArray *)labelArrayM
{
    if (!_labelArrayM) {
        NSMutableArray *arrayM = [NSMutableArray array];
        _labelArrayM = arrayM;
    }
    return _labelArrayM;
}

- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tag_add_icon"]  forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addTagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.x = 0;
        btn.size = btn.currentImage.size;
        btn.height = 3 * essenceMargin_x;
        
        [self.topView addSubview:btn];
        _plusBtn = btn;
    }
    return _plusBtn;
}

#pragma mark - 类方法加载
+ (instancetype)toolbar
{
    return [self loadViewFormXib:0];
}

#pragma mark - 初始化
- (void)awakeFromNib
{
    [super awakeFromNib];
    //添加加号按钮
//    self.plusBtn.x = essenceMargin_x;
    // 添加初始默认标签
    [self setupDefaultTag:@[@"吐槽", @"糗事"]];
    
}

#pragma mark - 关键方法设置区域
/** 子控件布局 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 标签布局;
    NSUInteger count = self.labelArrayM.count;
    
    for (NSUInteger i =0 ; i<count; i++) {
        UILabel *tagLabel = self.labelArrayM[i];
        
        if (i == 0) {
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else {
            CGFloat leftWith = CGRectGetMaxX([self.labelArrayM[i-1] frame]) + DIY;
            CGFloat rightWith = self.topView.width -leftWith;
            CGFloat tagLabelWidth = tagLabel.width;
            
            tagLabel.x = CGRectGetMaxX([self.labelArrayM[i-1] frame]) + DIY;
            tagLabel.y = [self.labelArrayM[i-1] y];
            
            if (tagLabelWidth > rightWith) {
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY([self.labelArrayM[i-1] frame]) + DIY;
            }
        }
    }
    
    // 加号布局
    UIButton *lastTagLabel = [self.labelArrayM lastObject];
    CGFloat leftWith = CGRectGetMaxX(lastTagLabel.frame) + DIY;
    CGFloat rightWith = self.topView.width -leftWith;
    
    self.plusBtn.x = 0;
    self.plusBtn.y = CGRectGetMaxY(lastTagLabel.frame);
    self.plusBtn.height = 3 * essenceMargin_y;
    
    if (50 <= rightWith) {
        self.plusBtn.x = CGRectGetMaxX(lastTagLabel.frame) + DIY;
        self.plusBtn.y = lastTagLabel.y;
    }
    
    if (count == 0) {
        self.plusBtn.x = 0;
        self.plusBtn.y = 0;
    }
    
    [self.plusBtn setBackgroundColor:CYAN_COLOR];
    // xib 的整体高度 = topView.height + accessView.height; (ps: 定为40);
    CGFloat lastLabelHeight = CGRectGetMaxY(self.plusBtn.frame) + 40;
    self.height = lastLabelHeight;
    NSLog(@"%.2f----%@", self.height, NSStringFromCGRect(self.frame));
    NSLog(@"%@", NSStringFromCGRect(self.topView.frame));
}

/** 添加标签 */
- (void)setupDefaultTag:(NSArray *)tagArray;
{
    [self.labelArrayM makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labelArrayM removeAllObjects];
    
    NSUInteger count = tagArray.count;
    
    for (NSUInteger i = 0; i< count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = WHITE_COLOR;
        label.backgroundColor = RGBColor(60, 120, 200, 1);
        label.font = FONT_12;
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = tagArray[i];
        [label sizeToFit];
        label.width += essenceMargin_x;
        label.height = 3 * essenceMargin_x;
        
        [self.topView addSubview:label];
        [self.labelArrayM addObject:label];
    }
}

#pragma mark - 响应的方法区域
- (void)addTagButtonClick:(UIButton *)sender
{
    HXLAddTagViewController *tagVC = [[HXLAddTagViewController alloc] init];
    // 设置顺传的值
    for (UILabel *label in self.labelArrayM) {
        [self.textArrayM addObject:label.text];
        NSLog(@"%@", label);
    }
    
    tagVC.textArray = self.textArrayM;
    // 因为此时的 releasePun是新 modal 出来的导航控制器的根控制器, 所以不会释放, 属性数组也不会释放, 即使当标签页面跳转进来时;    // 所以数组要主动清空, 不然标签会累加;
    self.textArrayM = nil;
    
    // 设置逆传的回调
    HXL_WEAKSELF;
    [tagVC setTextBlock:^(NSArray *tagTextArray){
        HXL_STRONGSELF;
        [strongSelf setupDefaultTag:tagTextArray];
    }];
    
    
    // 实现跳转页面
    UIViewController *tabBarSelectedC = KEYWINDOW.rootViewController;
    // 拿到被根控制器 presented 出来的那个导航控制器, 然后用这个 nav 来 push;
    HXLNavigationController *presentNav = (HXLNavigationController *)tabBarSelectedC.presentedViewController;
//    NSLog(@"tabBarSelectedC: %@---presentNav: %@", tabBarSelectedC, presentNav);
    [presentNav pushViewController:tagVC animated:YES];
}



@end

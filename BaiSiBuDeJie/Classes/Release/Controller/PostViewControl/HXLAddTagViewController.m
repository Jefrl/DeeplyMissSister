//
//  HXLAddTagViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/25.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLAddTagViewController.h"
#import "HXLTagButton.h"
#import "HXLAddTagToolbar.h"

@interface HXLAddTagViewController ()<UITextFieldDelegate>
/** contentView */
@property (nonatomic, readwrite, weak) UIView *contentView;
/** contentView */
@property (nonatomic, readwrite, weak) UITextField *textField;
/** addTagBtn */
@property (nonatomic, readwrite, strong) UIButton *addTagBtn;
/** tagBtnArrayM */
@property (nonatomic, readwrite, strong) NSMutableArray *tagBtnArrayM;
@end

@implementation HXLAddTagViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagBtnArrayM
{
    if (!_tagBtnArrayM) {
        NSMutableArray *arrM = [NSMutableArray array];
        _tagBtnArrayM = arrM;
    }
    return _tagBtnArrayM;
}

- (UIButton *)addTagBtn
{
    if (!_addTagBtn) {
        UIButton *addTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addTagBtn.hidden = YES;
        addTagBtn.titleLabel.font = FONT_12;
        [addTagBtn setBackgroundColor:RGBColor(60, 120, 200, 1)];
        addTagBtn.contentEdgeInsets = UIEdgeInsetsMake(0, DIY, 0, DIY);
        
        [self.contentView addSubview:addTagBtn];
        _addTagBtn = addTagBtn;
    }
    return _addTagBtn;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        
        contentView.x = DIY;
        contentView.y = NAVIGATIONBAR_HEIGHT;
        contentView.width = SCREEN_WIDTH - 2 * DIY;
        contentView.height = SCREEN_HEIGHT;
        contentView.backgroundColor = GRAY_PUBLIC_COLOR;
        
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    
    return _contentView;
}

- (UITextField *)textField
{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.font = FONT_12;
        textField.placeholder = @"多个标签用逗号或者换行隔开";
        [textField setValue:RED_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        [textField becomeFirstResponder];
        textField.backgroundColor = YELLOW_COLOR;
        
        // 监听 textfield 的之变化通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
        // 设置 frame
        textField.x = 0;
        textField.y = DIY;
        textField.width = self.contentView.width;
        textField.height = 3 * essenceMargin_y;
        
        [self.contentView addSubview:textField];
        _textField = textField;
    }
    
    return _textField;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self setupDefaultTags];
}

/** 初始化默认标签按钮 */
- (void)setupDefaultTags
{
    if (self.textArray.count) {
        for (NSString *text in self.textArray) {
            self.textField.text = text;
            [self addTagBtnClick:nil]; // 这里每次会创建 button;
        }
        // 因为 viewDidLayoutSubviews 会调用多次, 设置为nil 防止多个 button;
        self.textArray = nil;
    }
}


#pragma mark - 响应的方法区域
- (void)textDidChange:(NSNotification *)sender
{
    self.addTagBtn.hidden = YES;
    
    if (self.textField.hasText) {
        self.addTagBtn.hidden = NO;
        // 更新 标签增加按钮
        [self updateAddTagBtn];
        
        if (self.tagBtnArrayM.count) {
            // 更新 textfield
            [self updateTextFieldFrame];
        }
    }
}

- (void)addTagBtnClick:(UIButton *)sender
{
    HXLTagButton *tagBtn = [HXLTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:tagBtn];
    [self.tagBtnArrayM addObject:tagBtn];
    
    // 更新标签按钮
    [self updateTagBtn];
    // 更新 textfield
    [self updateTextFieldFrame];
    self.textField.text = nil;
    // 隐藏 标签添加按钮
    self.addTagBtn.hidden = YES;
    
}

/** 标签按钮的点击 */
- (void)tagBtnClick:(UIButton *)sender
{
    [self.tagBtnArrayM removeObject:sender];
    [sender removeFromSuperview];
    
    [self updateTagBtn];
    [self updateTextFieldFrame];
    [self updateAddTagBtn];
}

#pragma mark - 更新 frame

/** 更新 textfield */
- (void)updateTextFieldFrame
{
    UIButton *lastTagBtn = [self.tagBtnArrayM lastObject];
    CGFloat leftWith = CGRectGetMaxX(lastTagBtn.frame) + DIY;
    CGFloat rightWith = self.contentView.width -leftWith;
    
    self.textField.x = 0;
    self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + DIY;
    self.textField.height = 3*essenceMargin_y;
    
    if (100 <= rightWith) {
        self.textField.x = CGRectGetMaxX(lastTagBtn.frame) + DIY;
        self.textField.y = lastTagBtn.y;
    }
}

/** 更新 标签增加 按钮 */
- (void)updateAddTagBtn
{
    self.addTagBtn.x = 0;
    self.addTagBtn.y = CGRectGetMaxY(self.textField.frame) + DIY;
    
    [self.addTagBtn sizeToFit];
    self.addTagBtn.width += essenceMargin_x;
    self.addTagBtn.height = self.textField.height;
    
    [self.addTagBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
    [self.addTagBtn addTarget:self action:@selector(addTagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

/** 更新标签按钮 */
- (void)updateTagBtn
{
    NSUInteger count = self.tagBtnArrayM.count;
    
    for (NSUInteger i =0 ; i<count; i++) {
        UIButton *tagBtn = self.tagBtnArrayM[i];
        
        if (i == 0) {
            tagBtn.x = 0;
            tagBtn.y = DIY;
        } else {
            CGFloat leftWith = CGRectGetMaxX([self.tagBtnArrayM[i-1] frame]) + DIY;
            CGFloat rightWith = self.contentView.width -leftWith;
            CGFloat tagBtnWidth = tagBtn.width;
            
            tagBtn.x = CGRectGetMaxX([self.tagBtnArrayM[i-1] frame]) + DIY;
            tagBtn.y = [self.tagBtnArrayM[i-1] y];
            
            if (tagBtnWidth > rightWith) {
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY([self.tagBtnArrayM[i-1] frame]) + DIY;
            }
        }
        
    }
    
}

- (void)completeBtnClick:(UIButton *)sender
{
    NSLog(@"completeBtnClick");
    [self.view endEditing:YES];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (UIButton *btn in self.tagBtnArrayM) {
        NSString *tagText = btn.titleLabel.text;
        [arrayM addObject:tagText];
    }
    NSLog(@"%@", arrayM);
    self.textBlock(arrayM);
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 设置导航栏
- (void)setupNav
{
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemTitle:@"完成" titltColor:GRAY_COLOR titleSelectedColor:WHITE_COLOR fontSize:FONT_15 target:self action:@selector(completeBtnClick:) contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -DIY) forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
}
@end

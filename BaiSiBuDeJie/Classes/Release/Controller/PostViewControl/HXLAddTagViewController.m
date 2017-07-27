//
//  HXLAddTagViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/25.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLAddTagViewController.h"
#import "HXLTagButton.h"

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
        _addTagBtn = addTagBtn;
        _addTagBtn.hidden = YES;
        [_addTagBtn setBackgroundColor:RGBColor(60, 120, 200, 1)];
        [self.contentView addSubview:_addTagBtn];
    }
    return _addTagBtn;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        _contentView.x = DIY;
        _contentView.y = NAVIGATIONBAR_HEIGHT;
        _contentView.width = SCREEN_WIDTH - 2 * DIY;
        _contentView.height = SCREEN_HEIGHT;
        [self.view addSubview:_contentView];
        _contentView.backgroundColor = GRAY_PUBLIC_COLOR;
    }
    
    return _contentView;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupContentView];
    [self setupTextField];
    [self setupTag];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupContentView
{
    
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField setValue:RED_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    textField.font = FONT_12;
    
    textField.x = 0;
    textField.y = DIY;
    textField.width = self.contentView.width;
    textField.height = 3 * essenceMargin_y;
    [self.contentView addSubview:textField];

    self.textField = textField;
    [self.textField becomeFirstResponder];
    textField.backgroundColor = YELLOW_COLOR;
    // 监听 textfield 的之变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setupTag
{
    
}


#pragma mark - 响应的方法区域
- (void)textDidChange:(NSNotification *)sender
{
    self.addTagBtn.hidden = YES;

    if (self.textField.hasText) {
        self.addTagBtn.hidden = NO;
        
        self.addTagBtn.x = 0;
        self.addTagBtn.y = CGRectGetMaxY(self.textField.frame) + DIY;
        [self.addTagBtn sizeToFit];
        self.addTagBtn.height = self.textField.height;
        
        self.addTagBtn.titleLabel.font = FONT_12;
        [self.addTagBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        [self.addTagBtn addTarget:self action:@selector(addTagBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        self.textField.x = 0;
        self.textField.height = 3*essenceMargin_y;
        if (self.tagBtnArrayM.count) {
            UIButton *lastTagBtn = [self.tagBtnArrayM lastObject];
            
            CGFloat leftWith = CGRectGetMaxX(lastTagBtn.frame) + DIY;
            CGFloat rightWith = self.contentView.width -leftWith;

            self.textField.x = 0;
            self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + DIY;
            self.textField.height = 3*essenceMargin_y;
            
            if (130 <= rightWith) {
                self.textField.x = CGRectGetMaxX(lastTagBtn.frame) + DIY;
                self.textField.y = lastTagBtn.y;
            }
            
        }
    }
}

- (void)addTagBtnClick:(UIButton *)sender
{
    HXLTagButton *tagBtn = [HXLTagButton buttonWithType:UIButtonTypeCustom];
    tagBtn.titleLabel.font = FONT_12;
    [tagBtn setBackgroundColor:self.addTagBtn.backgroundColor];
    [tagBtn setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    
    [self.contentView addSubview:tagBtn];
    [self.tagBtnArrayM addObject:tagBtn];
    
    [self updateTagBtn];
    
}

- (void)updateTagBtn
{
    NSUInteger count = self.tagBtnArrayM.count;
    
    for (NSUInteger i =0 ; i<count; i++) {
        UIButton *tagBtn = self.tagBtnArrayM[i];
        if (i == 0) {
            tagBtn.x = 0;
            tagBtn.y = DIY;
            tagBtn.height = self.addTagBtn.height;
        } else {
            CGFloat leftWith = CGRectGetMaxX([self.tagBtnArrayM[i-1] frame]) + DIY;
            CGFloat rightWith = self.contentView.width -leftWith;
            CGFloat tabBtnWidth = tagBtn.width;
            
            tagBtn.x = CGRectGetMaxX([self.tagBtnArrayM[i-1] frame]) + DIY;
            tagBtn.y = [self.tagBtnArrayM[i-1] y];
            
            if (tabBtnWidth > rightWith) {
                
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY([self.tagBtnArrayM[i-1] frame]) + DIY;
            }
            
            tagBtn.height = self.addTagBtn.height;
            
        }
    }
    
    UIButton *lastTagBtn = [self.tagBtnArrayM lastObject];
    CGFloat leftWith = CGRectGetMaxX(lastTagBtn.frame) + DIY;
    CGFloat rightWith = self.contentView.width -leftWith;
    self.textField.x = 0;
    self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + DIY;
    if (130 <= rightWith) {
        self.textField.x = CGRectGetMaxX(lastTagBtn.frame) + DIY;
        self.textField.y = lastTagBtn.y;
    }
    
    self.textField.text = nil;
    self.textField.height = 3 * essenceMargin_y;
    
    self.addTagBtn.y = CGRectGetMaxY(self.textField.frame) + DIY;
    self.addTagBtn.hidden = YES;
    
}

- (void)completeBtnClick:(UIButton *)sender
{
    NSLog(@"");
}


#pragma mark - 设置导航栏
- (void)setupNav
{
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemTitle:@"完成" titltColor:GRAY_COLOR titleSelectedColor:WHITE_COLOR fontSize:FONT_15 target:self action:@selector(completeBtnClick:) contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -DIY) forControlEvents:UIControlEventTouchUpInside forcontrolState:UIControlStateHighlighted];
}
@end

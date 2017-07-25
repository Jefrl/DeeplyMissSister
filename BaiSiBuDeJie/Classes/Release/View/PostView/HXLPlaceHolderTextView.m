//
//  HXLPlaceHolderTextView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/24.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPlaceHolderTextView.h"

@interface HXLPlaceHolderTextView ()
/** placeholderLabel */
@property (nonatomic, readwrite, strong) UILabel *placeholderLabel;

@end

@implementation HXLPlaceHolderTextView
#pragma mark - 懒加载
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *label = [[UILabel alloc] init];
        _placeholderLabel = label;
        
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.backgroundColor = WHITE_COLOR;
        _placeholderLabel.textColor = GRAY_COLOR;
        _placeholderLabel.font = self.font;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

#pragma mark - 初始化 View
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 默认 textView 竖直方向始终有弹性
        self.alwaysBounceVertical = YES;
        self.backgroundColor = WHITE_COLOR;
        self.font = FONT_18;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 业务逻辑
- (void)layoutSubviews
{
    [super layoutSubviews];

    // 如果直接设置 控件的 Size, 也会 触发调用 layoutsubViews; 所以单独设置 width, height;
    CGSize size = [self.placeholderLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*DIY, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    _placeholderLabel.x = 7;
    _placeholderLabel.y = 7;
    _placeholderLabel.width = SCREEN_WIDTH - 2*7;
    self.placeholderLabel.height = size.height;
    
    NSLog(@"%@", NSStringFromCGRect(self.placeholderLabel.frame));
}

// 文字变化时
- (void)textDidChange:(NSNotification *)sender
{
    NSLog(@"%@---%@---%@", sender, sender.name, sender.object);
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - 设置自身的属性 setter 方法
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = _placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = _placeholder;
    
    [self setNeedsLayout];
}

#pragma mark - 重写父类 setter 方法
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    self.tintColor = textColor;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsLayout];
}


@end

//- (void)updatePlaceholderLabelSize
//{
//    self.placeholderLabel.width = SCREEN_WIDTH - 2 * self.placeholderLabel.x;
//    [self.placeholderLabel sizeToFit];
//    NSLog(@"%@", NSStringFromCGRect(self.placeholderLabel.frame));
//}

//绘制占位文字(一般重画时, 每次drawRect:之前, 会自动清除掉之前绘制的内容, 所以一旦擦除后, 就希望不要画了)
//- (void)drawRect:(CGRect)rect
//{
////    if (self.text.length || self.attributedText.length) return;
//    if (self.hasText) { // 在 @protocol UIKeyInput <UITextInputTraits>
//        return;
//    }
//
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = self.placeholderColor;
//    [attributes setValue:self.font forKeyPath:NSFontAttributeName];
//
//    rect = CGRectMake(DIY, 7, SCREEN_WIDTH - 2 * DIY, SCREEN_HEIGHT);
//    [self.placeholder drawInRect:rect withAttributes:attributes];
//}

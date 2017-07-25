//
//  HXLPlaceHolderTextView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/24.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPlaceHolderTextView.h"

@implementation HXLPlaceHolderTextView
#pragma mark - 初始化 View
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 默认 textView 竖直方向始终有弹性
        self.alwaysBounceVertical = YES;
        // 默认 占位文字的大小跟颜色
        self.placeholderColor = GRAY_COLOR;
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
// 文字变化时
- (void)textDidChange:(NSNotification *)sender;
{
    NSLog(@"%@---%@---%@", sender, sender.name, sender.object);
    [self setNeedsDisplay];
}

//绘制占位文字(一般重画时, 每次drawRect:之前, 会自动清除掉之前绘制的内容, 所以一旦擦除后, 就希望不要画了)
- (void)drawRect:(CGRect)rect
{
//    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) { // 在 @protocol UIKeyInput <UITextInputTraits>
        return;
    }
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = self.placeholderColor;
    [attributes setValue:self.font forKeyPath:NSFontAttributeName];
    
    rect = CGRectMake(DIY, 7, SCREEN_WIDTH - 2 * DIY, SCREEN_HEIGHT);
    [self.placeholder drawInRect:rect withAttributes:attributes];
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

@end

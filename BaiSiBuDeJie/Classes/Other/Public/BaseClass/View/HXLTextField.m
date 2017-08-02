//
//  HXLTextField.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/22.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLTextField.h"
#import <objc/runtime.h>

@implementation HXLTextField

+ (void)initialize
{
    // 列出成员属性;
//    [self getProperties];
    // 找出该类的所有实例变量, 包括私有的
    [self getIvars];
    
}
 
- (void)awakeFromNib
{
    [super awakeFromNib];
    // 光标的颜色
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

+ (void)getProperties
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (int i = 0; i< count; i++) {
        objc_property_t property = properties[i];
        NSLog(@"%s <--> %s", property_getName(property), property_getAttributes(property));
    }
    free(properties);
}

+ (void)getIvars
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s <---> %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    free(ivars);
}


- (BOOL)becomeFirstResponder
{
    UILabel *placeholdLabel = [self valueForKeyPath:@"_placeholderLabel"];
    placeholdLabel.textColor = WHITE_COLOR;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end

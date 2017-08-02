//
//  HXLDeleteTextField.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/8/2.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLDeleteTextField.h"

@implementation HXLDeleteTextField

// 输入退格删除键调用
- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    // 删除键的顺序直接决定 最后一个字符的长度 是否在 Block 调用前减还是调用后减;
    [super deleteBackward];
}

@end

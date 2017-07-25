//=================================================================
//                       HXLPopMenu.m
//=================================================================

#import "HXLPopMenu.h"

@implementation HXLPopMenu

- (IBAction)closeBtn:(UIButton *)sender
{
    self.popMenBlock();
//    // 通知外界
//    if ([self.delegate respondsToSelector:@selector(popMenuDidCloseBtn:)]) {
//        [self.delegate popMenuDidCloseBtn:self];
//    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
        self = array[0];
    }
    
    return self;
}

+ (instancetype)popMenu
{
    return [[self alloc] init];
}

- (void)showInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration completion:(void (^)())completion
{
    self.center = CGPointMake(- 0.5 *self.width, - 0.5 * self.height);
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:(duration * 0.2) animations:^{
        // 添加完蒙版
        completion();
        
    } completion:^(BOOL finished) {
        // 2.再添加 popMenu
        [[UIApplication sharedApplication].keyWindow addSubview:self];

        if (completion) {
            [UIView animateWithDuration:(duration + 0.3) animations:^{
                self.center = center;
                self.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }
        
    }];
}

- (void)hideInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration completion:(MyBlock)completion
{
    [UIView animateWithDuration:(duration * 0.8) animations:^{
        self.center = center;
        self.transform = CGAffineTransformMakeScale(0.7, 0.7);
        
    } completion:^(BOOL finished) {
        // 动画执行完移除 popMenu
        [self removeFromSuperview];
        
        // 2. 再移除蒙版
        if (completion) { // 判断外界有没有传递代码, 一般有移除自己的操作
            [UIView animateWithDuration:duration *0.2 animations:^{
                completion();
            }];
        }
    }];
    
}

@end

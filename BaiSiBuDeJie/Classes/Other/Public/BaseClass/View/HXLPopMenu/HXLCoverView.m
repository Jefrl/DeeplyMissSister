


#import "HXLCoverView.h"

@implementation HXLCoverView
+ (instancetype)coverViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7f;
    }
    
    return self;
}

- (void)show
{
    [KEYWINDOW addSubview:self];
}

- (void)hide
{
    for (UIView *view in KEYWINDOW.subviews) {
        if ([view isKindOfClass:[HXLCoverView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

@end

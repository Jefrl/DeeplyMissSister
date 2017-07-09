


#import "HXLCoverView.h"

@implementation HXLCoverView
+ (void)show:(CGRect)frame
{
    HXLCoverView *cover = [[self alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.7f;
    cover.frame = frame;
    [KEYWINDOW addSubview:cover];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7f;
        [KEYWINDOW addSubview:self];
    }
    
    return self;
}

+ (void)hide
{
    for (UIView *view in KEYWINDOW.subviews) {
        if ([view isKindOfClass:[HXLCoverView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

@end

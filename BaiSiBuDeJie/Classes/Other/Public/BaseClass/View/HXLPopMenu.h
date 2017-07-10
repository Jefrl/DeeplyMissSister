


typedef void(^MyBlock)();

#import <UIKit/UIKit.h>
@class HXLPopMenu;

@protocol HXLPopMenuDelegate <NSObject>
@optional
- (void)popMenuDidCloseBtn:(HXLPopMenu *)popMenu;


@end

@interface HXLPopMenu : UIView

+ (instancetype)showInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration;

- (void)hideInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration completion:(MyBlock)completion;

@property (nonatomic,weak) id<HXLPopMenuDelegate> delegate;

/** 替换代理的Block */
@property (nonatomic, readwrite, strong) void(^popMenBlock)();

@end

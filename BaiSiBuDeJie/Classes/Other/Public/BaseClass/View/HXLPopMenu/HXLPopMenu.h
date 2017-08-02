//=================================================================
//                       HXLPopMenu.h
//=================================================================


typedef void(^MyBlock)();

#import <UIKit/UIKit.h>
@class HXLPopMenu;

@protocol HXLPopMenuDelegate <NSObject>
@optional
- (void)popMenuDidCloseBtn:(HXLPopMenu *)popMenu;


@end

@interface HXLPopMenu : UIView
+ (instancetype)popMenu;

- (void)showInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration completion:(void (^)())completion;

- (void)hideInCenter:(CGPoint)center animateWithDuration:(NSTimeInterval)duration completion:(MyBlock)completion;

@property (nonatomic,weak) id<HXLPopMenuDelegate> delegate;

/** 替换代理的Block */
@property (nonatomic, readwrite, strong) void(^popMenBlock)();

@end

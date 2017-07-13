//
//  HXLMineFootView.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/13.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineFootView.h"
#import "HXLSessionManager.h"

@interface HXLMineFootView ()
/** sessionM */
@property (nonatomic, readwrite, strong) HXLSessionManager *sessionManager;

@end

@implementation HXLMineFootView

#pragma mark - Lazy load
- (HXLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        HXLSessionManager *sessionManager = [HXLSessionManager manager];
        _sessionManager = sessionManager;
    }
    return _sessionManager;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSMutableDictionary *paramenter = [NSMutableDictionary dictionary];
        paramenter[@""];
        
        [self.sessionManager request:RequestTypeGet URLString:HXLPUBLIC_URL parameters:paramenter success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            
        }];
    }
    
    return self;
}

@end

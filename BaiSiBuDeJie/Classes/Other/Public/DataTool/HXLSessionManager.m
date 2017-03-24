//
//  HXLSessionManager.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/14.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLSessionManager.h"


@implementation HXLSessionManager
/** 自定义封装 AFN 网络工具类 */
- (void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters resultBlock:(void(^)(id _Nullable responseObject, NSError *error))resultBlock
{
    // 定义 success block 块
    void(^successBlock)(NSURLSessionDataTask * _Nonnull , id  _Nullable ) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 执行请求成功的 block
        resultBlock(responseObject, nil);
    };
    // 定义 failure block 块
    void(^failBlock)(NSURLSessionDataTask * _Nonnull , NSError * _Nonnull ) = ^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 执行请求失败的 block
        resultBlock(nil, error);
   };
    
    if (requestType == RequestTypeGet) { // 发送GET 请求
        [self GET:urlStr parameters:parameters progress:nil success:successBlock failure:failBlock];
    } else if (requestType == RequestTypePost) { // 发送 post 请求
        [self POST:urlStr parameters:parameters progress:nil success:successBlock failure:failBlock];
    }
    
    
}

@end

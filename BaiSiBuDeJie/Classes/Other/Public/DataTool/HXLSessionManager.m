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
- (void)request:(RequestType)requestType
      URLString:(nullable NSString *)URLString
     parameters:(nullable NSDictionary *)parameters
        success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    if (requestType == RequestTypeGet) { // 发送GET 请求
        [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
    } else if (requestType == RequestTypePost) { // 发送 post 请求
        [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
    }
}

@end

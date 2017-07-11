//
//  HXLSessionManager.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/14.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//
#import "AFHTTPSessionManager.h"

typedef enum {
    RequestTypeGet,
    RequestTypePost
} RequestType;


@interface HXLSessionManager : AFHTTPSessionManager
/** 自定义封装 AFN 网络工具类 */
- (void)request:(RequestType)requestType
      URLString:(nullable NSString *)URLString
     parameters:(nullable NSDictionary *)parameters
        success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

@end


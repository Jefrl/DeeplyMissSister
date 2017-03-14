//
//  HXLSessionManager.h
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/14.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum {
    RequestTypeGet,
    RequestTypePost
} RequestType;


@interface HXLSessionManager : AFHTTPSessionManager
/** 自定义封装 AFN 网络工具类 */
- (void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;

@end

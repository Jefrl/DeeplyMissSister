//
//  HXLPunTableVC.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 17/3/10.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLPunTableVC.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@interface HXLPunTableVC ()

@end

@implementation HXLPunTableVC

NSString *const pubicUrl = @"http://api.budejie.com/api/api_open.php";
- (void)viewDidLoad {
    [super viewDidLoad];
    // 参数
    
    // 请求数据
    [SVProgressHUD show];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"type"] = @"41";
    params[@"c"] = @"data";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:pubicUrl parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        NSLog(@"%@", responseObject);
        [responseObject writeToFile:@"/Users/Jefrl/Desktop/pun.plist" atomically:YES];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
}

@end

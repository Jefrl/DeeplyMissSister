//
//  HXLMineWebViewController.m
//  BaiSiBuDeJie
//
//  Created by Jefrl on 2017/7/16.
//  Copyright © 2017年 com.Jefrl.www. All rights reserved.
//

#import "HXLMineWebViewController.h"
#import "NJKWebViewProgress.h"

@interface HXLMineWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goRefresh;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) NJKWebViewProgress *NJKProgressView;

@end

@implementation HXLMineWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.webView.delegate = self;
    
    self.NJKProgressView = [[NJKWebViewProgress alloc] init];
    // 饶了一圈
    self.webView.delegate = self.NJKProgressView;
    
    // 使用的框架, 需要
    HXL_WEAKSELF;
    self.NJKProgressView.progressBlock = ^(float progress) {
        
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
#warning - 为什么不起作用了呢?
    self.NJKProgressView.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)goRefresh:(UIBarButtonItem *)sender {
    [self.webView reload];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBack.enabled = YES;
    self.goForward.enabled = YES;
    
}


@end

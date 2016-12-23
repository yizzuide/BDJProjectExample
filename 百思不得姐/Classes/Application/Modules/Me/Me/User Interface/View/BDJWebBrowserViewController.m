//
//  BDJWebViewController.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJWebBrowserViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface BDJWebBrowserViewController () <UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBarButtonItem;

@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, weak) NJKWebViewProgressView *progressView;
@end

@implementation BDJWebBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLParams[@"url"]]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    self.backBarButtonItem.enabled = NO;
    self.forwardBarButtonItem.enabled = NO;
    
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    NJKWebViewProgressView *progressView = [[NJKWebViewProgressView alloc] init];
    progressView.y = 64;
    progressView.height = 2;
    progressView.width = ScreenSize.width;
    [self.view addSubview:progressView];
    self.progressView = progressView;
    [progressView setProgress:0.f];
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}

- (IBAction)goBackAction:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForwardAction:(id)sender {
    [self.webView goForward];
}
- (IBAction)refreshAction:(id)sender {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backBarButtonItem.enabled = [self.webView canGoBack];
    self.forwardBarButtonItem.enabled = [self.webView canGoForward];
}
@end

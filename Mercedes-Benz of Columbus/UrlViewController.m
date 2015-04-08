//
//  UrlViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 3/12/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "UrlViewController.h"
#import "Common.h"

#import "ProgressHUD.h"

@interface UrlViewController ()

@end

@implementation UrlViewController
@synthesize webView;
@synthesize url;
@synthesize title;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ProgressHUD show:@"Loading..."];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    [self.view addSubview:[Common headerWithTitle:title withIcon:[UIImage imageNamed:image] withBackground:[UIImage imageNamed:@"backgroundC.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    [webView setDelegate:self];
    [self.view addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [ProgressHUD showSuccess:@""];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [ProgressHUD showError:@""];
    [Common showErrorMessageWithTitle:@"Failed to load the URL." message:@"Please press the back button and try again." cancelButtonTitle:@"OK"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
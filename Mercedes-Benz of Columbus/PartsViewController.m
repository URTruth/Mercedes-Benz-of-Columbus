//
//  PartsViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 5/1/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "PartsViewController.h"
#import "HomeViewController.h"
#import "Common.h"

#import "ProgressHUD.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface PartsViewController ()

@end

@implementation PartsViewController
@synthesize webView;
@synthesize title;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ProgressHUD show:@"Loading..."];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [Common navigationBarTintColor];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    [self.view addSubview:[Common headerWithTitle: title withIcon:[UIImage imageNamed:image]
                                   withBackground:[UIImage imageNamed:@"backgroundC.png"]]];
    self.navigationItem.titleView = [[UIView alloc] init];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Parts", @"Accessories", @"Lifestyle", nil]];
    segmentedControl.frame = CGRectMake(10, 128, [UIScreen mainScreen].bounds.size.width - 20, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0,1,2;
    segmentedControl.tintColor = [UIColor lightGrayColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f] forKey:NSFontAttributeName];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 8, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    webView.scalesPageToFit=YES;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mbusa.com/mercedes/service_and_parts/genuine_parts"]];
    [webView loadRequest:urlRequest];
    [webView setDelegate:self];
    [self.view addSubview:webView];
}

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Parts page" forKey:kGAIScreenName] build]];
}

- (void)valueChanged:(UISegmentedControl *)segment {
    [ProgressHUD show:@"Loading..."];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    if(segment.selectedSegmentIndex == 0) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mbusa.com/mercedes/service_and_parts/genuine_parts"]]];
    } else if(segment.selectedSegmentIndex == 1) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mbusa.com/mercedes/accessories"]]];
    } else {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://accessories.mbusa.com"]]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.webView.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        // Do nothing
    } else {
        [ProgressHUD dismiss];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([self.webView.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        // Do nothing
    } else {
        [ProgressHUD dismiss];
        //[Common showErrorMessageWithTitle:@"Failed to load the URL." message:@"Please press the back button and try again." cancelButtonTitle:@"OK"];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

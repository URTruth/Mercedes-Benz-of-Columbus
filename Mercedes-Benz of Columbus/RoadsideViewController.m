//
//  RoadsideViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 3/9/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "RoadsideViewController.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "ProgressHUD.h"
#import "UIColor+FlatUI.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface RoadsideViewController ()

@end

@implementation RoadsideViewController
@synthesize settingData;
@synthesize backgroundView;
@synthesize scrollView;
@synthesize numberButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.view addSubview:backgroundView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1200);
    [self.view addSubview:scrollView];
    
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
    
    [scrollView addSubview:[Common headerWithTitle:@"Roadside Assist" withIcon:[UIImage imageNamed:@"roadside.png"] withBackground:[UIImage imageNamed:@"backgroundC.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    [ProgressHUD show:@"Loading..."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"page": @"roadside"};
    [manager POST:[Common webServiceUrlWithPath:@"get_settings.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        settingData = [responseObject objectForKey:@"settings"];
        [self createView];
        [ProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
        [ProgressHUD dismiss];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Roadside page" forKey:kGAIScreenName] build]];
}

- (void)createView {
    numberButton = [Common buttonWithText:[settingData objectForKey:@"phone_number"] color:[UIColor turquoiseColor] frame:CGRectMake(20, 143, [UIScreen mainScreen].bounds.size.width - 40, 50)];
    [numberButton addTarget:self action:@selector(roadsideButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:numberButton];
    
    UITextView *roadsideLabel = [[UITextView alloc]initWithFrame:CGRectMake(20, numberButton.frame.origin.y + numberButton.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 40, 15)];
    roadsideLabel.backgroundColor = [UIColor clearColor];
    roadsideLabel.clipsToBounds = YES;
    roadsideLabel.text = [settingData objectForKey:@"prompt"];
    [roadsideLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT  size: 15.0f]];
    roadsideLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    roadsideLabel.clipsToBounds = YES;
    roadsideLabel.scrollEnabled = NO;
    roadsideLabel.editable = NO;
    [roadsideLabel sizeToFit];
    [scrollView addSubview:roadsideLabel];
}

- (void) roadsideButtonClicked:(id)sender {
    NSString *unformattedNumber = [[[settingData objectForKey:@"phone_number"] componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[@"tel://" stringByAppendingString:unformattedNumber]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

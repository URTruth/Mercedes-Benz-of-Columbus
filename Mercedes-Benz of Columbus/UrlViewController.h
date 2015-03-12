//
//  UrlViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 3/12/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UrlViewController : UIViewController

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *image;

@end

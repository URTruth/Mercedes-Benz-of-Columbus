//
//  PartsViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 5/1/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartsViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *image;


@end

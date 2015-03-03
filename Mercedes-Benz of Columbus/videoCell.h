//
//  videoCell.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/20/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoCell : UITableViewCell


+ (videoCell *)cell;

@property (nonatomic, retain) IBOutlet UIWebView *webView;


@end

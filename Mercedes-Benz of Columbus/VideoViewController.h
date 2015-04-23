//
//  VideoViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/25/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PBYouTubeVideoViewController.h"

@interface VideoViewController : UITableViewController <UIGestureRecognizerDelegate, PBYouTubeVideoViewControllerDelegate>

@property(nonatomic, strong) NSMutableDictionary *videoData;

@end
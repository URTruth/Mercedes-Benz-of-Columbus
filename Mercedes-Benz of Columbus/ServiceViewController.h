//
//  ServiceViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AGPhotoBrowserView.h"

@interface ServiceViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AGPhotoBrowserDelegate, AGPhotoBrowserDataSource>

@property(nonatomic, strong) NSString *vin;
@property(nonatomic, strong) NSString *number;
@property(nonatomic, strong) NSMutableArray *serviceData;
@property(nonatomic, strong) NSMutableArray *historyData;

@property(nonatomic, strong) AGPhotoBrowserView *_photoBrowser;
@property(nonatomic, strong) NSArray *imageUrls;

@end

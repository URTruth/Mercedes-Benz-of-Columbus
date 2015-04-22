//
//  HistoryViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/21/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSString *order_number;
@property(nonatomic, strong) NSString *number;
@property(nonatomic, strong) NSMutableArray *serviceData;
@property(nonatomic, strong) NSMutableArray *detailData;

@end

//
//  ServiceViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceViewController : UITableViewController <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSString *vin;
@property(nonatomic, strong) NSString *order_number;
@property(nonatomic, strong) NSMutableArray *serviceData;

@end


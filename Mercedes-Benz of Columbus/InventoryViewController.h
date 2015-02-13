//
//  InventoryViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 2/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryViewController : UITableViewController <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *make;
@property(nonatomic, strong) NSString *model;
@property(nonatomic, strong) NSString *order;
@property(nonatomic, strong) NSString *vin;
@property(nonatomic, strong) NSMutableArray *vehicleData;

@end

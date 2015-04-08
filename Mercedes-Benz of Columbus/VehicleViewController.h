//
//  VehicleViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 2/11/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleViewController : UITableViewController

@property(nonatomic, strong) NSString *vin;
@property(nonatomic, strong) NSMutableArray *vehicleData;
@property(nonatomic, strong) NSMutableArray *detailData;

@property(nonatomic, strong) UIImageView *vehicleImageView;
@property(nonatomic, strong) UILabel *vehicleNameLabel;
@property(nonatomic, strong) UILabel *vehiclePriceLabel;

@end

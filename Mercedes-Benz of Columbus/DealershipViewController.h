//
//  DealershipViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DealershipViewController : UIViewController <MKMapViewDelegate>

@property(nonatomic, strong) NSMutableArray *departmentData;

@property(nonatomic, strong) UILabel *departmentNameLabel;
@property(nonatomic, strong) UILabel *departmentTelephoneLabel;
@property(nonatomic, strong) UILabel *mondayThroughFridayLabel;
@property(nonatomic, strong) UILabel *saturdayLabel;
@property(nonatomic, strong) UILabel *sundayLabel;

@end

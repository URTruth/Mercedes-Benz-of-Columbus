//
//  DealershipViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DealershipViewController : UIViewController <UIGestureRecognizerDelegate, MKMapViewDelegate>

@property(nonatomic, strong) NSMutableArray *departmentData;

@property(nonatomic, strong) UILabel *departmentNameLabel;
@property(nonatomic, strong) UILabel *departmentTelephoneLabel;
@property(nonatomic, strong) NSString *departmentEmail;
@property(nonatomic, strong) UILabel *mondayThroughFridayLabel;
@property(nonatomic, strong) UILabel *saturdayLabel;
@property(nonatomic, strong) UILabel *sundayLabel;

@property (nonatomic, strong) UIButton *directionsButton;
@property(nonatomic, strong) NSString *about;
@property(nonatomic, strong) NSURL *segueURL;
@property(nonatomic, strong) NSString *segueTitle;
@property(nonatomic, strong) NSString *segueImage;

@end

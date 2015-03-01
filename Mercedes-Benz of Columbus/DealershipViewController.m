//
//  DealershipViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "DealershipViewController.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"
#import "AddressAnnotation.h"

@interface DealershipViewController ()

@end

@implementation DealershipViewController
@synthesize departmentData;

@synthesize departmentNameLabel;
@synthesize departmentTelephoneLabel;
@synthesize mondayThroughFridayLabel;
@synthesize saturdayLabel;
@synthesize sundayLabel;

@synthesize about;

- (void)viewDidAppear:(BOOL)animated {
    // main view background color
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    departmentData = [@[
                        @{ @"name" : @"Sales", @"phone" : @"7062566100", @"email" : @"mboc@gmail.com", @"weekday_open_hour" : @"9:00 AM", @"weekday_close_hour" : @"7:00 PM", @"saturday_open_hour" : @"9:00 AM", @"saturday_close_hour" : @"6:00 PM", @"sunday_open_hour" : @"n/a", @"sunday_close_hour" : @"n/a" },
                        @{ @"name" : @"Service", @"phone" : @"7062566100", @"email" : @"mboc@gmail.com", @"weekday_open_hour" : @"7:30 AM", @"weekday_close_hour" : @"6:00 PM", @"saturday_open_hour" : @"n/a", @"saturday_close_hour" : @"n/a", @"sunday_open_hour" : @"n/a", @"sunday_close_hour" : @"n/a" },
                        @{ @"name" : @"Parts", @"phone" : @"7062566100", @"email" : @"mboc@gmail.com", @"weekday_open_hour" : @"8:00 AM", @"weekday_close_hour" : @"6:00 PM", @"saturday_open_hour" : @"n/a", @"saturday_close_hour" : @"n/a", @"sunday_open_hour" : @"n/a", @"sunday_close_hour" : @"n/a" }
                        ] mutableCopy];
    
    about = @"The only authorized Mercedes-Benz dealership in the Columbus, Georgia and Phenix City, Alabama area. *USAA special offers for active duty military, retired military, and spouses. A variety of models from: New Cars, Pre-Owned, and Certified Pre-Owned Vehicles. 24-7 Roadside Assistance (1-800-367-6372) Genuine Mercedes-Benz Parts and Accessories. Courtesy shuttles to Ft. Benning when you bring your car in for service. All Mercedes-Benz of Columus Technicians are Master Certified with over 69 years of combined experience. Stay up-to-date with the offical Mercedes-Benz of Columbus facebook page, for the latest information about upcoming events and service specials.";
    
    int scrollHeight = 1100;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 65)];
    scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, scrollHeight);
    [self.view addSubview:scrollview];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    [scrollview addSubview:[Common headerWithTitle:@"Our Dealership" withIcon:[UIImage imageNamed:@"dealership.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    // Gray background
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 123, [UIScreen mainScreen].bounds.size.width, scrollHeight)];
    [centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    centerView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [scrollview addSubview:centerView];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 95, 22, 32, 32)];
    phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
    [phoneImageView setBackgroundColor:[UIColor clearColor]];
    phoneImageView.alpha = .5;
    [phoneImageView setImage:[UIImage imageNamed:@"phone.png"]];
    [centerView addSubview:phoneImageView];
    
    UIImageView *emailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(phoneImageView.frame.origin.x + phoneImageView.frame.size.width + 15, phoneImageView.frame.origin.y, phoneImageView.frame.size.width, phoneImageView.frame.size.height)];
    emailImageView.contentMode = UIViewContentModeScaleAspectFit;
    [emailImageView setBackgroundColor:[UIColor clearColor]];
    emailImageView.alpha = .5;
    [emailImageView setImage:[UIImage imageNamed:@"email.png"]];
    [centerView addSubview:emailImageView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 15)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.clipsToBounds = YES;
    nameLabel.text = @"Mercedes-Benz of Columbus";
    [nameLabel setTextAlignment: UITextAlignmentLeft];
    [nameLabel setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    nameLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:nameLabel];
    
    UILabel * telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, nameLabel.frame.origin.y + nameLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 14)];
    telephoneLabel.backgroundColor = [UIColor clearColor];
    telephoneLabel.clipsToBounds = YES;
    telephoneLabel.text = @"(706) 256-6100";
    [telephoneLabel setTextAlignment: UITextAlignmentLeft];
    [telephoneLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f]];
    telephoneLabel.textColor = [UIColor peterRiverColor];
    [centerView addSubview:telephoneLabel];
    
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, telephoneLabel.frame.origin.y + telephoneLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.clipsToBounds = YES;
    addressLabel.text = @"7470 Veterans Parkway · Columbus, GA 31909";
    [addressLabel setTextAlignment: UITextAlignmentLeft];
    [addressLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    addressLabel.textColor = [UIColor grayColor];
    [centerView addSubview:addressLabel];
    
    // Map
    MKMapView * map = [[MKMapView alloc] initWithFrame: CGRectMake(10, addressLabel.frame.origin.y + addressLabel.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.width - 20)];
    map.layer.cornerRadius = 5;
    [map.layer setMasksToBounds:YES];
    map.delegate = self;
    //map.mapType = MKMapTypeHybrid;
    CLLocationCoordinate2D coord = {.latitude =  32.55346, .longitude =  -84.94564};
    MKCoordinateSpan span = {.latitudeDelta =  0.00725, .longitudeDelta =  0.00725}; // half a mile
    MKCoordinateRegion region = {coord, span};
    [map setRegion:region animated:YES];
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:coord];
    [map addAnnotation:addAnnotation];
    [centerView addSubview:map];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Sales", @"Service", @"Parts", nil]];
    segmentedControl.frame = CGRectMake(10, map.frame.origin.y + map.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor CustomGrayColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f] forKey:NSFontAttributeName];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [centerView addSubview:segmentedControl];
    
    UIImageView *departmentPhoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 95, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 22, 32, 32)];
    departmentPhoneImageView.contentMode = UIViewContentModeScaleAspectFit;
    [departmentPhoneImageView setBackgroundColor:[UIColor clearColor]];
    departmentPhoneImageView.alpha = .5;
    [departmentPhoneImageView setImage:[UIImage imageNamed:@"phone.png"]];
    [centerView addSubview:departmentPhoneImageView];
    
    UIImageView *departmentEmailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(departmentPhoneImageView.frame.origin.x + departmentPhoneImageView.frame.size.width + 15, departmentPhoneImageView.frame.origin.y, departmentPhoneImageView.frame.size.width, departmentPhoneImageView.frame.size.height)];
    departmentEmailImageView.contentMode = UIViewContentModeScaleAspectFit;
    [departmentEmailImageView setBackgroundColor:[UIColor clearColor]];
    departmentEmailImageView.alpha = .5;
    [departmentEmailImageView setImage:[UIImage imageNamed:@"email.png"]];
    [centerView addSubview:departmentEmailImageView];
    
    NSDictionary* departmentItem = [departmentData objectAtIndex:0];
    
    departmentNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, 15)];
    departmentNameLabel.backgroundColor = [UIColor clearColor];
    departmentNameLabel.clipsToBounds = YES;
    departmentNameLabel.text = [[departmentItem objectForKey:@"name"] stringByAppendingString:@" Department"];
    [departmentNameLabel setTextAlignment: UITextAlignmentLeft];
    [departmentNameLabel setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    departmentNameLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:departmentNameLabel];
    
    departmentTelephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, departmentNameLabel.frame.origin.y + departmentNameLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 14)];
    departmentTelephoneLabel.backgroundColor = [UIColor clearColor];
    departmentTelephoneLabel.clipsToBounds = YES;
    departmentTelephoneLabel.text = [Common formatPhoneNumber:[departmentItem objectForKey:@"phone"]];
    [departmentTelephoneLabel setTextAlignment: UITextAlignmentLeft];
    [departmentTelephoneLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f]];
    departmentTelephoneLabel.textColor = [UIColor peterRiverColor];
    [centerView addSubview:departmentTelephoneLabel];

    UILabel * hoursLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, departmentTelephoneLabel.frame.origin.y + departmentTelephoneLabel.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, 14)];
    hoursLabel.backgroundColor = [UIColor clearColor]; //2980B9
    hoursLabel.clipsToBounds = YES;
    hoursLabel.text = @"Hours of Operation";
    [hoursLabel setTextAlignment: UITextAlignmentLeft];
    [hoursLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f]];
    hoursLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:hoursLabel];
    
    mondayThroughFridayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, hoursLabel.frame.origin.y + hoursLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    mondayThroughFridayLabel.backgroundColor = [UIColor clearColor];
    mondayThroughFridayLabel.clipsToBounds = YES;
    mondayThroughFridayLabel.text = [@"Monday - Friday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"weekday_open_hour"] andEnd:[departmentItem objectForKey:@"weekday_close_hour"]]];
    [mondayThroughFridayLabel setTextAlignment: UITextAlignmentLeft];
    [mondayThroughFridayLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    mondayThroughFridayLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:mondayThroughFridayLabel];
    
    saturdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, mondayThroughFridayLabel.frame.origin.y + mondayThroughFridayLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    saturdayLabel.backgroundColor = [UIColor clearColor];
    saturdayLabel.clipsToBounds = YES;
    saturdayLabel.text = [@"Saturday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"saturday_open_hour"] andEnd:[departmentItem objectForKey:@"saturday_close_hour"]]];
    [saturdayLabel setTextAlignment: UITextAlignmentLeft];
    [saturdayLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    saturdayLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:saturdayLabel];
    
    sundayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, saturdayLabel.frame.origin.y + saturdayLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    sundayLabel.backgroundColor = [UIColor clearColor];
    sundayLabel.clipsToBounds = YES;
    sundayLabel.text = [@"Sunday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"sunday_open_hour"] andEnd:[departmentItem objectForKey:@"sunday_close_hour"]]];
    [sundayLabel setTextAlignment: UITextAlignmentLeft];
    [sundayLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    sundayLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:sundayLabel];
    
    UILabel * aboutLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, sundayLabel.frame.origin.y + sundayLabel.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, 14)];
    aboutLabel.backgroundColor = [UIColor clearColor];
    aboutLabel.clipsToBounds = YES;
    aboutLabel.text = @"About Us";
    [aboutLabel setTextAlignment: UITextAlignmentLeft];
    [aboutLabel setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    aboutLabel.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:aboutLabel];
    
    UITextView *aboutText = [[UITextView alloc]initWithFrame:CGRectMake(10, aboutLabel.frame.origin.y + aboutLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    aboutText.backgroundColor = [UIColor clearColor];
    aboutText.clipsToBounds = YES;
    aboutText.text = about;
    [aboutText sizeToFit];
    [aboutText setTextAlignment: UITextAlignmentLeft];
    [aboutText setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    aboutText.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:aboutText];
}

- (void)valueChanged:(UISegmentedControl *)segment {
    NSDictionary* departmentItem = [departmentData objectAtIndex:segment.selectedSegmentIndex];
    departmentNameLabel.text = [[departmentItem objectForKey:@"name"] stringByAppendingString:@" Department"];
    departmentTelephoneLabel.text = [Common formatPhoneNumber:[departmentItem objectForKey:@"phone"]];
    mondayThroughFridayLabel.text = [@"Monday - Friday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"weekday_open_hour"] andEnd:[departmentItem objectForKey:@"weekday_close_hour"]]];
    saturdayLabel.text = [@"Saturday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"saturday_open_hour"] andEnd:[departmentItem objectForKey:@"saturday_close_hour"]]];
    sundayLabel.text = [@"Sunday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"sunday_open_hour"] andEnd:[departmentItem objectForKey:@"sunday_close_hour"]]];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"coordinates = %f,%f", mapView.userLocation.coordinate.latitude,
          mapView.userLocation.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: actionlist
}

@end

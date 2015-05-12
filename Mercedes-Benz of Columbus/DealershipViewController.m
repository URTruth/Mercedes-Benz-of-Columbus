//
//  DealershipViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "DealershipViewController.h"
#import "UrlViewController.h"
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
@synthesize departmentEmail;
@synthesize mondayThroughFridayLabel;
@synthesize saturdayLabel;
@synthesize sundayLabel;
@synthesize directionsButton;
@synthesize about;
@synthesize segueURL;
@synthesize segueTitle;
@synthesize segueImage;

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
                        @{ @"name" : @"Parts", @"phone" : @"7062566100", @"email" : @"mboc@gmail.com", @"weekday_open_hour" : @"8:00 AM", @"weekday_close_hour" : @"6:00 PM", @"saturday_open_hour" : @"n/a", @"saturday_close_hour" : @"n/a", @"sunday_open_hour" : @"n/a", @"sunday_close_hour" : @"n/a" },
                        @{ @"name" : @"Inquire", @"phone" : @"7062566100", @"email" : @"mboc@gmail.com", @"weekday_open_hour" : @"*", @"weekday_close_hour" : @"*", @"saturday_open_hour" : @"*", @"saturday_close_hour" : @"*", @"sunday_open_hour" : @"*", @"sunday_close_hour" : @"*" }
                        ] mutableCopy];
    
    about = @"We are the only authorized Mercedes-Benz dealership in the Columbus, Georgia and Phenix City, Alabama area. We offer a variety of cars and advantages from: New Cars, Pre-Owned, Certified Pre-Owned Vehicles, 24-7 Roadside Assistance, and Genuine Mercedes-Benz Parts and Accessories.";
    
    int scrollHeight = 1100;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 65)];
    scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, scrollHeight);
    [self.view addSubview:scrollview];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [Common navigationBarTintColor];
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
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    // Gray background
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 123, [UIScreen mainScreen].bounds.size.width, scrollHeight)];
    [centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    centerView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [scrollview addSubview:centerView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 23, [UIScreen mainScreen].bounds.size.width - 20, 16)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.clipsToBounds = YES;
    nameLabel.text = @"Mercedes-Benz of Columbus";
    [nameLabel setTextAlignment: UITextAlignmentLeft];
    [nameLabel setFont:[UIFont fontWithName: BOLD_FONT size: 16.0f]];
    nameLabel.textColor = [UIColor peterRiverColor];
    [centerView addSubview:nameLabel];
    
    UIImageView *facebookImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 90, nameLabel.frame.origin.y - 10, 32, 32)];
    facebookImageView.contentMode = UIViewContentModeScaleAspectFit;
    [facebookImageView setBackgroundColor:[UIColor clearColor]];
    [facebookImageView setImage:[UIImage imageNamed:@"facebook.png"]];
    [facebookImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *facebookTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebookClicked:)];
    [facebookTapRecognizer setNumberOfTouchesRequired:1];
    [facebookTapRecognizer setDelegate:self];
    [facebookImageView addGestureRecognizer:facebookTapRecognizer];
    [centerView addSubview:facebookImageView];
    
    UIImageView *twitterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(facebookImageView.frame.origin.x + facebookImageView.frame.size.width + 10, facebookImageView.frame.origin.y, facebookImageView.frame.size.width, facebookImageView.frame.size.height)];
    twitterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [twitterImageView setBackgroundColor:[UIColor clearColor]];
    [twitterImageView setImage:[UIImage imageNamed:@"twitter.png"]];
    [twitterImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *twitterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twitterClicked:)];
    [twitterTapRecognizer setNumberOfTouchesRequired:1];
    [twitterTapRecognizer setDelegate:self];
    [twitterImageView addGestureRecognizer:twitterTapRecognizer];
    [centerView addSubview:twitterImageView];
    
    UITextView *aboutText = [[UITextView alloc]initWithFrame:CGRectMake(10, nameLabel.frame.origin.y + nameLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    aboutText.backgroundColor = [UIColor clearColor];
    aboutText.clipsToBounds = YES;
    aboutText.scrollEnabled = NO;
    aboutText.editable = NO;
    aboutText.text = about;
    [aboutText setTextAlignment: UITextAlignmentLeft];
    [aboutText setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    aboutText.textColor = [UIColor colorFromHexCode:@"353535"];
    [centerView addSubview:aboutText];
    [aboutText sizeToFit];
    [aboutText layoutIfNeeded];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Sales", @"Service", @"Parts", @"Inquire", nil]];
    segmentedControl.frame = CGRectMake(10, aboutText.frame.origin.y + aboutText.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 30);
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
    [departmentPhoneImageView setImage:[UIImage imageNamed:@"phone.png"]];
    [departmentPhoneImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *phoneTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneClicked:)];
    [phoneTapRecognizer setNumberOfTouchesRequired:1];
    [phoneTapRecognizer setDelegate:self];
    [departmentPhoneImageView addGestureRecognizer:phoneTapRecognizer];
    [centerView addSubview:departmentPhoneImageView];
    
    UIImageView *departmentEmailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(departmentPhoneImageView.frame.origin.x + departmentPhoneImageView.frame.size.width + 15, departmentPhoneImageView.frame.origin.y, departmentPhoneImageView.frame.size.width, departmentPhoneImageView.frame.size.height)];
    departmentEmailImageView.contentMode = UIViewContentModeScaleAspectFit;
    [departmentEmailImageView setBackgroundColor:[UIColor clearColor]];
    [departmentEmailImageView setImage:[UIImage imageNamed:@"email.png"]];
    [departmentEmailImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *emailTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailClicked:)];
    [emailTapRecognizer setNumberOfTouchesRequired:1];
    [emailTapRecognizer setDelegate:self];
    [departmentEmailImageView addGestureRecognizer:emailTapRecognizer];
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
    
    departmentEmail = [departmentItem objectForKey:@"email"];

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
    
    directionsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    directionsButton.backgroundColor = [UIColor clearColor];
    directionsButton.frame = CGRectMake(10, sundayLabel.frame.origin.y + sundayLabel.frame.size.height + 25, 200, 15);
    directionsButton.layer.cornerRadius=8.0f;
    directionsButton.layer.masksToBounds=YES;
    [directionsButton setBackgroundColor:[UIColor clearColor]];
    directionsButton.layer.borderColor=[[UIColor clearColor]CGColor];
    directionsButton.layer.borderWidth= 1.0f;
    directionsButton.clipsToBounds = YES;
    directionsButton.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
    [directionsButton setTitle:@"Location" forState:UIControlStateNormal];
    [directionsButton setTitleColor:[UIColor peterRiverColor] forState:UIControlStateNormal];
    directionsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [directionsButton addTarget:self
                         action:@selector(directionsAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [directionsButton setTag:1];
    [centerView addSubview:directionsButton];
    
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, directionsButton.frame.origin.y + directionsButton.frame.size.height + 12, [UIScreen mainScreen].bounds.size.width - 20, 12)];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.clipsToBounds = YES;
    addressLabel.text = @"7470 Veterans Parkway · Columbus, GA 31909";
    [addressLabel setTextAlignment: UITextAlignmentLeft];
    [addressLabel setFont:[UIFont fontWithName: SEMI_BOLD_FONT size: 12.0f]];
    addressLabel.textColor = [UIColor CustomGrayColor];
    [centerView addSubview:addressLabel];
    
    // Map
    MKMapView * map = [[MKMapView alloc] initWithFrame: CGRectMake(20, addressLabel.frame.origin.y + addressLabel.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.width - 40)];
    map.scrollEnabled = NO;
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
    UITapGestureRecognizer *mapTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapClicked:)];
    [mapTapRecognizer setNumberOfTouchesRequired:1];
    [mapTapRecognizer setDelegate:self];
    [map addGestureRecognizer:mapTapRecognizer];
    [centerView addSubview:map];

}

- (void)valueChanged:(UISegmentedControl *)segment {
    NSDictionary* departmentItem = [departmentData objectAtIndex:segment.selectedSegmentIndex];
    departmentNameLabel.text = [[departmentItem objectForKey:@"name"] stringByAppendingString:@" Department"];
    departmentTelephoneLabel.text = [Common formatPhoneNumber:[departmentItem objectForKey:@"phone"]];
    departmentEmail = [departmentItem objectForKey:@"email"];
    mondayThroughFridayLabel.text = [@"Monday - Friday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"weekday_open_hour"] andEnd:[departmentItem objectForKey:@"weekday_close_hour"]]];
    saturdayLabel.text = [@"Saturday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"saturday_open_hour"] andEnd:[departmentItem objectForKey:@"saturday_close_hour"]]];
    sundayLabel.text = [@"Sunday · " stringByAppendingString:[Common formatTimeRangeWithStart:[departmentItem objectForKey:@"sunday_open_hour"] andEnd:[departmentItem objectForKey:@"sunday_close_hour"]]];
    if([[departmentItem objectForKey:@"name"] isEqualToString:@"Inquire"]) {
        [self performSegueWithIdentifier:@"appointmentSegue" sender:self];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"coordinates = %f,%f", mapView.userLocation.coordinate.latitude,
          mapView.userLocation.coordinate.longitude);
}

- (void) facebookClicked:(id)sender {
    segueURL = [NSURL URLWithString:@"https://www.facebook.com/MercedesBenzofColumbus"];
    segueTitle = @"Facebook";
    segueImage = @"facebook.png";
    [self performSegueWithIdentifier:@"urlSegue" sender:self];
}

- (void) twitterClicked:(id)sender {
    segueURL = [NSURL URLWithString:@"https://twitter.com/MBColumbusGa"];
    segueTitle = @"Twitter";
    segueImage = @"twitter.png";
    [self performSegueWithIdentifier:@"urlSegue" sender:self];
}

- (void) phoneClicked:(id)sender {
    NSString *unformattedNumber = [[departmentTelephoneLabel.text componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[@"tel://" stringByAppendingString:unformattedNumber]]];
}

- (void) emailClicked:(id)sender {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", departmentEmail]]];
}

- (void) mapClicked:(id)sender {
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(32.55346,-84.94564);
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%f,%f",location.latitude,location.longitude]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?q=7470+Veterans+Parkway+Columbus,+GA+31909"]];
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        NSLog(@"Google Maps app is not installed");
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?q=7470+Veterans+Parkway+Columbus,+GA+31909"]];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"urlSegue"]){
        UrlViewController *dest = (UrlViewController *)[segue destinationViewController];
        dest.url = segueURL;
        dest.title = segueTitle;
        dest.image = segueImage;
    }
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: actionlist
}

@end

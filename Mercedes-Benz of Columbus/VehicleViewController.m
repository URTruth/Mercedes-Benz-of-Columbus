//
//  VehicleViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 2/11/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "VehicleViewController.h"
#import "AccountViewController.h"
#import "AppointmentViewController.h"
#import "vehicleDetailCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"
#import "ProgressHUD.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface VehicleViewController ()

@end

@implementation VehicleViewController
@synthesize vin;
@synthesize vehicleData;
@synthesize detailData;
@synthesize settingData;
@synthesize vehicleImageView;
@synthesize vehicleNameLabel;
@synthesize vehiclePriceLabel;
@synthesize _photoBrowser;
@synthesize imageUrls;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-65,0,0,0);
    self.tableView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    
    detailData = [@[
                  @{ @"name" : @"Images", @"icon" : @"images.png", @"key" : @"urls", @"segue" : @"vehicleImagesSegue" },
                  @{ @"name" : @"Type", @"icon" : @"showroom.png", @"key" : @"type", @"segue" : @"n/a" },
                  @{ @"name" : @"Year", @"icon" : @"year.png", @"key" : @"year", @"segue" : @"n/a" },
                  @{ @"name" : @"Make", @"icon" : @"showroom.png", @"key" : @"make", @"segue" : @"n/a" },
                  @{ @"name" : @"Model", @"icon" : @"showroom.png", @"key" : @"model", @"segue" : @"n/a" },
                  @{ @"name" : @"Body", @"icon" : @"showroom.png", @"key" : @"body", @"segue" : @"n/a" },
                  @{ @"name" : @"Color", @"icon" : @"color.png", @"key" : @"color", @"segue" : @"n/a" },
                  @{ @"name" : @"Trim", @"icon" : @"trim.png", @"key" : @"trim", @"segue" : @"n/a" },
                  @{ @"name" : @"Stock #", @"icon" : @"stock.png", @"key" : @"stock_number", @"segue" : @"n/a" },
                  @{ @"name" : @"MPG", @"icon" : @"mpg.png", @"key" : @"mpg", @"segue" : @"n/a" },
                  @{ @"name" : @"Cylinders", @"icon" : @"cylinders.png", @"key" : @"cylinders", @"segue" : @"n/a" },
                  @{ @"name" : @"Engine", @"icon" : @"engine.png", @"key" : @"engine", @"segue" : @"n/a" },
                  @{ @"name" : @"Mileage", @"icon" : @"mpg.png", @"key" : @"odometer", @"segue" : @"n/a" },
                  ] mutableCopy];
    
    [self refresh];
 }

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Vehicle page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    [ProgressHUD show:@"Loading.."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"vin": vin};
    [manager POST:[NSString stringWithFormat:@"http://www.wavelinkllc.com/mboc/%@", ([self isSegueFromAccountPage] ? @"get_vehicle.php" : @"get_vehicle_from_inventory.php")] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        vehicleData = responseObject;
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
    }];
}

- (BOOL)isDataAvailable {
    return ([vehicleData count] > 0 ? YES : NO);
}

- (BOOL)isSegueFromAccountPage {
    return [[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2] isKindOfClass:[AccountViewController class]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ([self isDataAvailable] ? 3 : 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return ([self isDataAvailable] ? [detailData count] : 0);
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self isDataAvailable]) {
        NSDictionary* vehicleItem = [vehicleData objectAtIndex:0];
        
        if(indexPath.section == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presentationCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"presentationCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
                cell.contentView.clipsToBounds = YES;
                cell.clipsToBounds = YES;
                
                vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
                [vehicleImageView setContentMode:UIViewContentModeScaleAspectFill];
                [cell addSubview:vehicleImageView];
                
                UIImageView *text_veil = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
                [text_veil setContentMode:UIViewContentModeScaleAspectFill];
                [text_veil setImage:[UIImage imageNamed:@"text-veil.png"]];
                [cell addSubview:text_veil];
                
                int vehicleNameFont = 24;
                vehicleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, text_veil.frame.size.height/4/1.75, [UIScreen mainScreen].bounds.size.width - 40, vehicleNameFont)];
                [vehicleNameLabel setFont:[UIFont fontWithName:LIGHT_FONT size:vehicleNameFont]];
                [vehicleNameLabel setTextColor:[UIColor whiteColor]];
                [text_veil addSubview:vehicleNameLabel];
                
                int vehiclePriceFont = 17;
                vehiclePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, vehicleNameLabel.frame.origin.y + vehicleNameLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width/2 - 20, vehiclePriceFont)];
                [vehiclePriceLabel setFont:[UIFont fontWithName:BOLD_FONT size:vehiclePriceFont]];
                [vehiclePriceLabel setTextColor:[UIColor greenSeaColor]];
                [text_veil addSubview:vehiclePriceLabel];
            }
            
            NSString *stringOfUrls = [vehicleItem objectForKey:@"urls"];
            imageUrls = (![stringOfUrls isEqual:[NSNull null]]) ? [([stringOfUrls hasSuffix:@","]) ? [stringOfUrls substringToIndex:[stringOfUrls length] - 1] : stringOfUrls componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
            [vehicleImageView setImageWithURL:[NSURL URLWithString:[imageUrls objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"no-vehicle-image.png"]];
            
            [vehicleNameLabel setText:[vehicleItem objectForKey:@"name"]];
            
            [vehiclePriceLabel setText:[vehicleItem objectForKey:@"price"]];
            
            return cell;
        }
        
        if(indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"buttonCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
                cell.contentView.clipsToBounds = YES;
                cell.clipsToBounds = YES;
                
                FUIButton * callButton = [Common buttonWithText:@"Call" color:[UIColor greenSeaColor] frame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width/2 - 20, 40)];
                [callButton addTarget:self action:@selector(callButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:callButton];
                
                FUIButton * quoteButton = [Common buttonWithText:@"Request Quote" color:[UIColor asbestosColor] frame:CGRectMake(callButton.frame.origin.x + callButton.frame.size.width + 10, 10, [UIScreen mainScreen].bounds.size.width/2 - 20, 40)];
                [quoteButton addTarget:self action:@selector(quoteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:quoteButton];
            }
            
            return cell;
        }
        
        if(indexPath.section == 2) {
            static NSString *vehicleDetailCellIdentifier = @"vehicleDetailCell";
            vehicleDetailCell *cell = (vehicleDetailCell *)[tableView dequeueReusableCellWithIdentifier:vehicleDetailCellIdentifier];
            if (cell == nil){ cell = [[vehicleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleDetailCellIdentifier]; }
          
            NSDictionary* detailItem = [detailData objectAtIndex:indexPath.row];
            [cell.photoImageView setImage:[UIImage imageNamed:[detailItem objectForKey:@"icon"]]];
            [cell.nameLabel setText:[detailItem objectForKey:@"name"]];
            
            if([[detailItem objectForKey:@"key"] isEqualToString:@"urls"]) {
                NSString *stringOfUrls = [vehicleItem objectForKey:@"urls"];
                int count = (![stringOfUrls isEqual:[NSNull null]]) ? [[([stringOfUrls hasSuffix:@","]) ? [stringOfUrls substringToIndex:[stringOfUrls length] - 1] : stringOfUrls componentsSeparatedByString: @","] count] : 0;
                cell.auxLabel.text = [NSString stringWithFormat:@"(%d)", count];
                cell.arrowLabel.alpha = 1;
            } else {
                [cell.auxLabel setText:(![[vehicleItem objectForKey:[detailItem objectForKey:@"key"]] isEqual:[NSNull null]] && ![[vehicleItem objectForKey:[detailItem objectForKey:@"key"]] isEqualToString:@""]) ? [vehicleItem objectForKey:[detailItem objectForKey:@"key"]] : @"--"];
                cell.arrowLabel.alpha = 0;
            }

            return cell;
        }
    }
    
    vehicleDetailCell *cell = [[vehicleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.photoImageView setImage:[UIImage imageNamed:@"warranty.png"]];
    CGRect photoFrame = cell.photoImageView.frame;
    cell.photoImageView.frame = CGRectMake(photoFrame.origin.x, photoFrame.origin.y + 45, photoFrame.size.width, photoFrame.size.height);
    if([self isSegueFromAccountPage]) {
        [cell.nameLabel setText:@"No data available."];
        cell.auxLabel.text = @"Try updating the VIN number in Settings.";
        CGRect auxFrame = cell.auxLabel.frame;
        cell.auxLabel.frame = CGRectMake(auxFrame.origin.x, auxFrame.origin.y + 52, auxFrame.size.width, auxFrame.size.height);
        [cell.auxLabel setFont:[UIFont fontWithName:BOLD_FONT size:12]];
    } else {
        [cell.nameLabel setText:@"No data available."];
        cell.auxLabel.text = @"";
    }
    CGRect nameFrame = cell.nameLabel.frame;
    cell.nameLabel.frame = CGRectMake(nameFrame.origin.x, nameFrame.origin.y + 52, nameFrame.size.width, nameFrame.size.height);
    cell.arrowLabel.alpha = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return ([self isDataAvailable] ? [UIScreen mainScreen].bounds.size.width : 800);
    }
    if(indexPath.section == 1) {
        return 62;
    }
    if(indexPath.section == 2) {
        return 78;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        [self.photoBrowser show];
    }
    if(indexPath.section == 2) {
        NSDictionary* detailItem = [detailData objectAtIndex:indexPath.row];
        if([[detailItem objectForKey:@"key"] isEqualToString:@"urls"]) {
            [self.photoBrowser show];
        }
    }
}

- (NSInteger)numberOfPhotosForPhotoBrowser:(AGPhotoBrowserView *)photoBrowser {
    return [imageUrls count];
}

- (UIImage *)photoBrowser:(AGPhotoBrowserView *)photoBrowser imageAtIndex:(NSInteger)index {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imageUrls objectAtIndex: index]]]];
}

- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser titleForImageAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"Image %d", index + 1];
}

- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser descriptionForImageAtIndex:(NSInteger)index
{
    return [[vehicleData objectAtIndex:0] objectForKey:@"name"];
}

- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton
{
    [self.photoBrowser hideWithCompletion:^(BOOL finished){

    }];
}

- (AGPhotoBrowserView *)photoBrowser
{
    if (!_photoBrowser) {
        _photoBrowser = [[AGPhotoBrowserView alloc] initWithFrame:CGRectZero];
        _photoBrowser.delegate = self;
        _photoBrowser.dataSource = self;
    }
    
    return _photoBrowser;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"vehicleSegue"]){
        VehicleViewController *dest = (VehicleViewController *)[segue destinationViewController];
        dest.vin = vin;
    }
    if([segue.identifier isEqualToString:@"appointmentSegue"]){
        AppointmentViewController *dest = (AppointmentViewController *)[segue destinationViewController];
        dest.selection = @"Get ePrice";
        dest.vin = vin;
    }
}

- (void) callButtonClicked:(id)sender {
    if(settingData != nil) {
        [self call];
    } else {
        [ProgressHUD show:@"Loading..."];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"page": @"vehicle"};
        [manager POST:[Common webServiceUrlWithPath:@"get_settings.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            settingData = [responseObject objectForKey:@"settings"];
            [self call];
            [ProgressHUD dismiss];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
            [ProgressHUD dismiss];
        }];
    }
}

- (void) call {
    NSString *unformattedNumber = [[[settingData objectForKey:@"phone_number"] componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[@"tel://" stringByAppendingString:unformattedNumber]]];
}

- (void) quoteButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"appointmentSegue" sender:self];
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: add actionsheet here
}

- (void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

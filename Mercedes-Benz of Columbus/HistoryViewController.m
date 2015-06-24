//
//  HistoryViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/21/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "HistoryViewController.h"
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

@interface HistoryViewController ()

@end

@implementation HistoryViewController
@synthesize order_number;
@synthesize number;
@synthesize serviceData;
@synthesize detailData;

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
    self.tableView.backgroundColor = [UIColor blackColor];
    
    number = @"7062566100";
    detailData = [@[
                    @{ @"name" : @"Order Number", @"icon" : @"warranty.png", @"key" : @"order_number", @"segue" : @"n/a" },
                    @{ @"name" : @"Service Date", @"icon" : @"year.png", @"key" : @"open_date", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 1", @"icon" : @"warranty.png", @"key" : @"description_1", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 2", @"icon" : @"warranty.png", @"key" : @"description_2", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 3", @"icon" : @"warranty.png", @"key" : @"description_3", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 4", @"icon" : @"warranty.png", @"key" : @"description_4", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 5", @"icon" : @"warranty.png", @"key" : @"description_5", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 6", @"icon" : @"warranty.png", @"key" : @"description_6", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 7", @"icon" : @"warranty.png", @"key" : @"description_7", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 8", @"icon" : @"warranty.png", @"key" : @"description_8", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 9", @"icon" : @"warranty.png", @"key" : @"description_9", @"segue" : @"n/a" },
                    @{ @"name" : @"Description 10", @"icon" : @"warranty.png", @"key" : @"description_10", @"segue" : @"n/a" },
                    @{ @"name" : @"VIN #", @"icon" : @"stock.png", @"key" : @"vin", @"segue" : @"n/a" },
                    @{ @"name" : @"Make", @"icon" : @"showroom.png", @"key" : @"make", @"segue" : @"n/a" },
                    @{ @"name" : @"Model", @"icon" : @"showroom.png", @"key" : @"model", @"segue" : @"n/a" },
                    @{ @"name" : @"Year", @"icon" : @"year.png", @"key" : @"year", @"segue" : @"n/a" },
                    @{ @"name" : @"Mileage", @"icon" : @"mpg.png", @"key" : @"odometer", @"segue" : @"n/a" },
                    @{ @"name" : @"Color", @"icon" : @"color.png", @"key" : @"color", @"segue" : @"n/a" },
                    @{ @"name" : @"Stock #", @"icon" : @"stock.png", @"key" : @"stock_number", @"segue" : @"n/a" }
                    ] mutableCopy];
    
    [self refresh];
}

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createAppView] set:@"History page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    [ProgressHUD show:@"Loading.."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"order_number": order_number};
    [manager POST:@"http://www.wavelinkllc.com/mboc/get_service.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        serviceData = responseObject;
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
    }];
}

- (BOOL)isDataAvailable {
    return ([serviceData count] > 0 ? YES : NO);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return ([self isDataAvailable] ? [detailData count] : 1);
        default: return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:@"Service History" withIcon:[UIImage imageNamed:@"service.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if([self isDataAvailable]) {
        NSDictionary* serviceItem = [serviceData objectAtIndex:0];
        
        if(indexPath.section == 1) {
            static NSString *vehicleDetailCellIdentifier = @"vehicleDetailCell";
            vehicleDetailCell *cell = (vehicleDetailCell *)[tableView dequeueReusableCellWithIdentifier:vehicleDetailCellIdentifier];
            if (cell == nil){ cell = [[vehicleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleDetailCellIdentifier]; }
            
            NSDictionary* detailItem = [detailData objectAtIndex:indexPath.row];
            [cell.photoImageView setImage:[UIImage imageNamed:[detailItem objectForKey:@"icon"]]];
            [cell.nameLabel setText:[detailItem objectForKey:@"name"]];
            [cell.auxLabel setText:[serviceItem objectForKey:[detailItem objectForKey:@"key"]]];
            cell.arrowLabel.alpha = 0;
            
            return cell;
        }
    } else {
        vehicleDetailCell *cell = [[vehicleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSDictionary* detailItem = [detailData objectAtIndex:indexPath.row];
        [cell.photoImageView setImage:[UIImage imageNamed:@"warranty.png"]];
        CGRect photoFrame = cell.photoImageView.frame;
        cell.photoImageView.frame = CGRectMake(photoFrame.origin.x, photoFrame.origin.y + 45, photoFrame.size.width, photoFrame.size.height);
        [cell.nameLabel setText:@"No data available."];
        CGRect nameFrame = cell.nameLabel.frame;
        cell.nameLabel.frame = CGRectMake(nameFrame.origin.x, nameFrame.origin.y + 52, nameFrame.size.width, nameFrame.size.height);
        cell.auxLabel.text = @"";
        cell.arrowLabel.alpha = 0;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blankCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 122;
    }
    if(indexPath.section == 1) {
        return ([self isDataAvailable] ? 78 : 800);
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
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

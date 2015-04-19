//
//  ServiceViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "ServiceViewController.h"
#import "serviceCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"
#import "ProgressHUD.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController
@synthesize vin;
@synthesize number;
@synthesize serviceData;
@synthesize historyData;
@synthesize _photoBrowser;
@synthesize imageUrls;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-65,0,0,0);
    self.tableView.backgroundColor = [UIColor blackColor];
    
    historyData = [@[
                    @{ @"name" : @"Oil Change and Fluids", @"icon" : @"oil.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Tires and Tire Repair", @"icon" : @"tire.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Transmission", @"icon" : @"transmission.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Engine", @"icon" : @"engine.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Brakes and Brake Repair", @"icon" : @"brakes.jpg", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Filters", @"icon" : @"filter.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Mufflers and Exhaust", @"icon" : @"muffler.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Belts and Hoses", @"icon" : @"belts.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Lights, Wipers and Accessories Repair", @"icon" : @"wiper.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Steering and Suspension", @"icon" : @"suspension.png", @"key" : @"n/a", @"segue" : @"n/a" },
                    @{ @"name" : @"Car Heating and A/C", @"icon" : @"heat.jpg", @"key" : @"n/a", @"segue" : @"n/a" },
                    ] mutableCopy];
    
    [self refresh];


}

- (void)viewDidAppear:(BOOL)animated {
//    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Vehicle page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
//    // Send a asynchronous request for the initial menu data
//    [ProgressHUD show:@"Loading.."];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"vin": vin};
//    [manager POST:@"http://www.wavelinkllc.com/mboc/get_vehicle.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        serviceData = responseObject;
//        [self.tableView reloadData];
//        [ProgressHUD dismiss];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [ProgressHUD dismiss];
//        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return [historyData count];
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* serviceItem = [serviceData objectAtIndex:0];
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:@"Service History" withIcon:[UIImage imageNamed:@"service.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        
    }
    
    if(indexPath.section == 2) {
        static NSString *serviceCellIdentifier = @"serviceCell";
        serviceCell *cell = (serviceCell *)[tableView dequeueReusableCellWithIdentifier:serviceCellIdentifier];
        if (cell == nil){ cell = [[serviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceCellIdentifier];
        }
        
        NSDictionary* detailItem = [historyData objectAtIndex:indexPath.row];
        [cell.photoImageView setImage:[UIImage imageNamed:[detailItem objectForKey:@"icon"]]];
        [cell.nameLabel setText:[detailItem objectForKey:@"name"]];
        
        if([[detailItem objectForKey:@"key"] isEqualToString:@"urls"]) {
            NSString *stringOfUrls = [serviceItem objectForKey:@"urls"];
            int count = (![stringOfUrls isEqual:[NSNull null]]) ? [[([stringOfUrls hasSuffix:@","]) ? [stringOfUrls substringToIndex:[stringOfUrls length] - 1] : stringOfUrls componentsSeparatedByString: @","] count] : 0;
            cell.auxLabel.text = [NSString stringWithFormat:@"(%d)", count];
            cell.arrowLabel.alpha = 1;
        } else {
            [cell.auxLabel setText:(![[serviceItem objectForKey:[detailItem objectForKey:@"key"]] isEqual:[NSNull null]] && ![[serviceItem objectForKey:[detailItem objectForKey:@"key"]] isEqualToString:@""]) ? [serviceItem objectForKey:[detailItem objectForKey:@"key"]] : @"--"];
            cell.arrowLabel.alpha = 0;
        }
        
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
        return 0;
    }
    if(indexPath.section == 2) {
        return 78;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == 1) {
//        [self.photoBrowser show];
//    }
//    if(indexPath.section == 2) {
//        NSDictionary* detailItem = [detailData objectAtIndex:indexPath.row];
//        if([[detailItem objectForKey:@"key"] isEqualToString:@"urls"]) {
//            [self.photoBrowser show];
//        }
//    }
}

//- (NSInteger)numberOfPhotosForPhotoBrowser:(AGPhotoBrowserView *)photoBrowser {
//    return [imageUrls count];
//}
//
//- (UIImage *)photoBrowser:(AGPhotoBrowserView *)photoBrowser imageAtIndex:(NSInteger)index {
//    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imageUrls objectAtIndex: index]]]];
//}
//
//- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser titleForImageAtIndex:(NSInteger)index
//{
//    return [NSString stringWithFormat:@"Image %d", index + 1];
//}
//
//- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser descriptionForImageAtIndex:(NSInteger)index
//{
//    return [[vehicleData objectAtIndex:0] objectForKey:@"name"];
//}
//
//- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton
//{
//    [self.photoBrowser hideWithCompletion:^(BOOL finished){
//        
//    }];
//}

//- (AGPhotoBrowserView *)photoBrowser
//{
//    if (!_photoBrowser) {
//        _photoBrowser = [[AGPhotoBrowserView alloc] initWithFrame:CGRectZero];
//        _photoBrowser.delegate = self;
//        _photoBrowser.dataSource = self;
//    }
//    
//    return _photoBrowser;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"historySegue"]){
        ServiceViewController *dest = (ServiceViewController *)[segue destinationViewController];
     //   dest.vin = vin;
    }
}

//- (void) callButtonClicked:(id)sender {
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[@"tel://" stringByAppendingString:number]]];
//}

- (void) quoteButtonClicked:(id)sender {
    
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
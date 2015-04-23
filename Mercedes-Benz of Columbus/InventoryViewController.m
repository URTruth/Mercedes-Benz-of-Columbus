//
//  InventoryViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 2/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "InventoryViewController.h"
#import "VehicleViewController.h"
#import "vehicleCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"
#import "ProgressHUD.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController
@synthesize type;
@synthesize make;
@synthesize model;
@synthesize order;
@synthesize vin;
@synthesize vehicleData;

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
    
    order = @"";
    [self refresh];
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Inventory page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    [ProgressHUD show:@"Loading..."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"next": @0, @"type": type, @"make": make, @"model": model, @"order": order};
    [manager POST:@"http://www.wavelinkllc.com/mboc/get_inventory.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        vehicleData = responseObject;
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return [vehicleData count];
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:[NSString stringWithFormat:@"%@ %@", make, model] withIcon:[UIImage imageNamed:@"showroom.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        
    }
    
    if(indexPath.section == 2) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        NSDictionary* vehicleItem = [vehicleData objectAtIndex:indexPath.row];
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"no-vehicle-image.png"]];
        [cell.nameLabel setText:[vehicleItem objectForKey:@"name"]];
        [cell.priceLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"price"]]];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@ · %@ · %@", [vehicleItem objectForKey:@"type"], [vehicleItem objectForKey:@"color"], [vehicleItem objectForKey:@"body"]]];
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
        return 88;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) {
        NSDictionary* vehicleItem = [vehicleData objectAtIndex:indexPath.row];
        vin = [vehicleItem objectForKey:@"vin"];
        [self performSegueWithIdentifier:@"vehicleSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"vehicleSegue"]){
        VehicleViewController *dest = (VehicleViewController *)[segue destinationViewController];
        dest.vin = vin;
    }
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

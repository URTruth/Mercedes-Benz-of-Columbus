//
//  VehicleViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 2/11/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "VehicleViewController.h"
#import "vehicleDetailCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"

@interface VehicleViewController ()

@end

@implementation VehicleViewController
@synthesize vin;
@synthesize vehicleData;
@synthesize detailData;
@synthesize vehicleImageView;
@synthesize vehicleNameLabel;
@synthesize vehiclePriceLabel;

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
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Vehicle page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"vin": vin};
    [manager POST:@"http://www.wavelinkllc.com/mboc/get_vehicle.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        vehicleData = responseObject;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
        case 2: return [detailData count];
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* vehicleItem = [vehicleData objectAtIndex:0];
    
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:[vehicleItem objectForKey:@"name"] withIcon:[UIImage imageNamed:@"showroom.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presentationCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"presentationCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
            
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
        
        NSArray *images = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [vehicleImageView setImageWithURL:[NSURL URLWithString:[images objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"no-vehicle-image.png"]];
        
        [vehicleNameLabel setText:[vehicleItem objectForKey:@"name"]];
        
        [vehiclePriceLabel setText:[vehicleItem objectForKey:@"price"]];
        
        return cell;
    }
    
    if(indexPath.section == 2) {
        static NSString *vehicleDetailCellIdentifier = @"vehicleDetailCell";
        vehicleDetailCell *cell = (vehicleDetailCell *)[tableView dequeueReusableCellWithIdentifier:vehicleDetailCellIdentifier];
        if (cell == nil){ cell = [[vehicleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleDetailCellIdentifier]; }
      
        NSDictionary* detailItem = [detailData objectAtIndex:indexPath.row];
        [cell.photoImageView setImage:[UIImage imageNamed:[detailItem objectForKey:@"icon"]]];
        [cell.nameLabel setText:[detailItem objectForKey:@"name"]];
        [cell.auxLabel setText:(![[vehicleItem objectForKey:[detailItem objectForKey:@"key"]] isEqual:[NSNull null]] && ![[vehicleItem objectForKey:[detailItem objectForKey:@"key"]] isEqualToString:@""]) ? [vehicleItem objectForKey:[detailItem objectForKey:@"key"]] : @"--"];

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
        return [UIScreen mainScreen].bounds.size.width;
    }
    if(indexPath.section == 2) {
        return 78;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

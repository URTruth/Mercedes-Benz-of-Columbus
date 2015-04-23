//
//  ShowroomViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "ShowroomViewController.h"
#import "InventoryViewController.h"
#import "vehicleCell.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"
#import "ProgressHUD.h"

@interface ShowroomViewController ()

@end

@implementation ShowroomViewController
@synthesize type;
@synthesize make;
@synthesize model;
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
    
    type = @"new";
    [self refresh];
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Showroom page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    [ProgressHUD show:@"Loading..."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"next": @0, @"type": type};
    [manager POST:@"http://www.wavelinkllc.com/mboc/get_showroom.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        return [Common headerOfType:Default withTitle:@"Showroom" withIcon:[UIImage imageNamed:@"showroom.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"segmentedControlCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segmentedControlCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"New", @"Used", nil]];
            segmentedControl.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 30);
            segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
            segmentedControl.selectedSegmentIndex = 0;
            segmentedControl.tintColor = [UIColor CustomGrayColor];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f] forKey:NSFontAttributeName];
            [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            [segmentedControl addTarget:self action:@selector(typeChanged:) forControlEvents: UIControlEventValueChanged];
            [cell addSubview:segmentedControl];
        }
        return cell;
    }
    
    if(indexPath.section == 2) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        NSDictionary* vehicleItem = [vehicleData objectAtIndex:indexPath.row];
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"no-vehicle-image.png"]];
        [cell.nameLabel setText:[vehicleItem objectForKey:@"name"]];
        [cell.priceLabel setText:[NSString stringWithFormat:@"From %@", [vehicleItem objectForKey:@"price"]]];
        [cell.auxLabel setText:[NSString stringWithFormat:@"(%@ available)", [vehicleItem objectForKey:@"count"]]];
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
        return 50;
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
        make = [vehicleItem objectForKey:@"make"];
        model = [vehicleItem objectForKey:@"model"];
        [self performSegueWithIdentifier:@"inventorySegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"inventorySegue"]){
        InventoryViewController *dest = (InventoryViewController *)[segue destinationViewController];
        dest.type = type;
        dest.make = make;
        dest.model = model;
    }
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: add actionsheet here
}

- (void)typeChanged:(UISegmentedControl *)segment {
    if(segment.selectedSegmentIndex == 0) {
        type = @"new";
    } else {
        type = @"used";
    }
    [self refresh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

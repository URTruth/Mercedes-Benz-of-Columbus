//
//  ShowroomViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "ShowroomViewController.h"
#import "vehicleCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"

@interface ShowroomViewController ()

@end

@implementation ShowroomViewController
@synthesize vehicleData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[Common alloc] backButton];
    
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
    
    UIBarButtonItem *optionsButton = [[Common alloc] optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-65,0,0,0);
    self.tableView.backgroundColor = [UIColor blackColor];
    
    vehicleData = [@[
                   @{ @"name" : @"Mercedes-Benz C-Class", @"photo" : @"http://www.mbusa.com/vcm/MB/DigitalAssets/Vehicles/ClassLanding/2015/C/Sedan/Gallery/2015-C-CLASS-SEDAN-GALLERY-007-GOE-D.jpg", @"start_price" : @"42985", @"type" : @"New", @"number_available" : @"18" },
                   @{ @"name" : @"Mercedes-Benz CLA-Class", @"photo" : @"http://www.mbusa.com/vcm/MB/DigitalAssets/Vehicles/ClassLanding/2014/CLA/Gallery/2014-CLA-CLASS-COUPE-GALLERY-004-GOE-D.jpg", @"start_price" : @"33745", @"type" : @"New", @"number_available" : @"14" },
                   @{ @"name" : @"Mercedes-Benz CLS-Class", @"photo" : @"http://www.mbusa.com/vcm/MB/DigitalAssets/Vehicles/ClassLanding/2015/CLS/Gallery/2015-CLS-CLASS-COUPE-GALLERY-001-GOE-D.jpg", @"start_price" : @"74285", @"type" : @"New", @"number_available" : @"7" }
                  ] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Showroom page" forKey:kGAIScreenName] build]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        return [[Common alloc] headerOfType:Default withTitle:@"Showroom" withIcon:[UIImage imageNamed:@"showroom.png"]];
    }
    
    if(indexPath.section == 1) {
        
    }
    
    if(indexPath.section == 2) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        NSDictionary* vehicleItem = [vehicleData objectAtIndex:indexPath.row];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[vehicleItem objectForKey:@"photo"]] placeholderImage:[UIImage imageNamed:@"montage.png"]];
        [cell.nameLabel setText:[vehicleItem objectForKey:@"name"]];
        [cell.priceLabel setText:[NSString stringWithFormat:@"From $%@", [vehicleItem objectForKey:@"start_price"]]];
        [cell.auxLabel setText:[NSString stringWithFormat:@"(%@ - %@ available)", [vehicleItem objectForKey:@"type"], [vehicleItem objectForKey:@"number_available"]]];
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
        //[self performSegueWithIdentifier:@"vehicleListSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: add actionsheet here
}

@end

//
//  AccountViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "AccountViewController.h"
#import "HomeViewController.h"
#import "VehicleViewController.h"
#import "ServiceViewController.h"
#import "UrlViewController.h"
#import "menuCell.h"
#import "specialsCell.h"
#import "User.h"
#import "Common.h"

#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"
#import "ProgressHUD.h"

@interface HomeViewController ()

@end

@implementation AccountViewController
@synthesize menuData;

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
    self.tableView.separatorColor = [UIColor whiteColor];
    
    /*
     // Send a asynchronous request for the initial menu data
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     NSDictionary *parameters = @{@"userId": self.userId};
     [manager POST:feedURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     feedData = responseObject;
     [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     [self showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
     }];
     */
    
    menuData = [@[
                  @{ @"name" : @"My Vehicle", @"icon" : @"showroom.png", @"badge" : @"0", @"segue" : @"vehicleSegue", @"url" : @"n/a" },
                  @{ @"name" : @"Service History", @"icon" : @"service.png", @"badge" : @"0", @"segue" : @"serviceSegue", @"url" : @"n/a" },
                  //@{ @"name" : @"Share This App", @"icon" : @"specials.png", @"badge" : @"0", @"segue" : @"comingSoonSegue", @"url" : @"n/a" },
                  @{ @"name" : @"Settings", @"icon" : @"engine.png", @"badge" : @"0", @"segue" : @"settingsSegue", @"url" : @"n/a" },
                  @{ @"name" : @"Back To Home", @"icon" : @"nav.png", @"badge" : @"0", @"segue" : @"homeSegue", @"url" : @"n/a" },
                  @{ @"name" : @"Logout", @"icon" : @"account.png", @"badge" : @"0", @"segue" : @"homeSegue", @"url" : @"n/a" }
                  ] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"My Account" forKey:kGAIScreenName] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return [menuData count];
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"] withBackground:[UIImage imageNamed:@"backgroundD.png"]];
    }
    
    if(indexPath.section == 1) {
        static NSString *menuCellIdentifier = @"menuCell";
        menuCell *cell = (menuCell *)[tableView dequeueReusableCellWithIdentifier:menuCellIdentifier];
        if (cell == nil){ cell = [[menuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellIdentifier]; }
        
        NSDictionary* menuItem = [menuData objectAtIndex:indexPath.row];
        cell.nameLabel.text = [menuItem objectForKey:@"name"];
        cell.iconImageView.image = [UIImage imageNamed:[menuItem objectForKey:@"icon"]];
        if(![[menuItem objectForKey:@"badge"] isEqualToString:@"0"]) {
            cell.badgeLabel.text = [menuItem objectForKey:@"badge"];
            cell.badgeLabel.alpha = 1;
            float width = [cell.badgeLabel.text boundingRectWithSize:cell.badgeLabel.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:cell.badgeLabel.font } context:nil].size.width;
            CGRect frame = cell.badgeLabel.frame;
            frame.origin.x = [UIScreen mainScreen].bounds.size.width - width - 40;
            frame.size.width = width + 20;
            cell.badgeLabel.frame = frame;
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
        return 51;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        selectedRow = indexPath.row;
        NSDictionary* menuItem = [menuData objectAtIndex:indexPath.row];
        if([[menuItem objectForKey:@"name"] isEqualToString:@"Logout"]){
            [ProgressHUD show:@"Loading..."];
            [[User sharedInstance] logout:^(BOOL isSuccess) {
                if(isSuccess) {
                    [ProgressHUD dismiss];
                    [self performSegueWithIdentifier:[menuItem objectForKey:@"segue"] sender:self];
                } else {
                    [ProgressHUD dismiss];
                    [Common showErrorMessageWithTitle:@"Failed to logout." message:@"Please try again." cancelButtonTitle:@"OK"];
                }
            }];
        } else {
            [self performSegueWithIdentifier:[menuItem objectForKey:@"segue"] sender:self];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"urlSegue"]){
        UrlViewController *dest = (UrlViewController *)[segue destinationViewController];
        NSDictionary* menuItem = [menuData objectAtIndex:selectedRow];
        dest.url = [NSURL URLWithString:[menuItem objectForKey:@"url"]];
        dest.title = [menuItem objectForKey:@"name"];
        dest.image = [menuItem objectForKey:@"icon"];
    } else if([segue.identifier isEqualToString:@"vehicleSegue"]){
        VehicleViewController *dest = (VehicleViewController *)[segue destinationViewController];
        dest.vin = [User sharedInstance].vin;
    } else if([segue.identifier isEqualToString:@"serviceSegue"]){
        ServiceViewController *dest = (ServiceViewController *)[segue destinationViewController];
        dest.vin = [User sharedInstance].vin;
    }
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: actionlist
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
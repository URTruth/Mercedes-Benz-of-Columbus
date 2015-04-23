//
//  HomeViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 12/1/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "HomeViewController.h"
#import "UrlViewController.h"
#import "menuCell.h"
#import "specialsCell.h"
#import "Common.h"

#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize menuData;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationItem.hidesBackButton = YES;
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
    self.navigationItem.rightBarButtonItem = optionsButton;

    self.tableView.contentInset = UIEdgeInsetsMake(-65,0,0,0);
    self.tableView.backgroundColor = [UIColor blackColor];
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
                  @{ @"name" : @"Our Dealership", @"icon" : @"dealership.png", @"badge" : @"0", @"segue" : @"dealershipSegue", @"url" : @"n/a" },
                @{ @"name" : @"Roadside Assistance", @"icon" : @"roadside.png", @"badge" : @"0", @"segue" : @"roadsideSegue", @"url" : @"n/a" },
                @{ @"name" : @"Special Offers", @"icon" : @"specials.png", @"badge" : @"2", @"segue" : @"specialsSegue", @"url" : @"n/a" },
                @{ @"name" : @"Showroom", @"icon" : @"showroom.png", @"badge" : @"0", @"segue" : @"showroomSegue", @"url" : @"n/a" },
                @{ @"name" : @"My Vehicle", @"icon" : @"account.png", @"badge" : @"0", @"segue" : @"signInSegue", @"url" : @"n/a" },
                @{ @"name" : @"Mercedes-Benz Financial", @"icon" : @"payment.png", @"badge" : @"0", @"segue" : @"comingSoonSegue", @"url" : @"n/a" },
                @{ @"name" : @"Request Service", @"icon" : @"service.png", @"badge" : @"0", @"segue" : @"serviceSegue", @"url" : @"n/a" },
                @{ @"name" : @"Genuine Parts", @"icon" : @"parts.png", @"badge" : @"0", @"segue" : @"urlSegue", @"url" : @"http://www.mercedesbenzofcolumbus.com/service" },
                @{ @"name" : @"Videos", @"icon" : @"gray-video.png", @"badge" : @"4", @"segue" : @"videoSegue", @"url" : @"n/a" },
                //@{ @"name" : @"Check Warranty Coverage", @"icon" : @"warranty.png", @"badge" : @"0", @"segue" : @"warrantySegue", @"url" : @"n/a" },
                @{ @"name" : @"Rate Us", @"icon" : @"thumb.png", @"badge" : @"0", @"segue" : @"urlSegue", @"url" : @"https://www.dealerrater.com/dealer/Mercedes-Benz-of-Columbus-review-18279/" },
                ] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Home page" forKey:kGAIScreenName] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return [menuData count];
        case 2: return 1;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [Common headerOfType:Home withTitle:nil withIcon:nil withBackground:[UIImage imageNamed:@"backgroundD.png"]];
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
    
    if(indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 320) / 2, 0, 320, 60)];
        
        UILabel *poweredLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 45, 100, 16)];
        [poweredLabel setText:@"Powered by"];
        [poweredLabel setTextColor: [UIColor whiteColor]];
        [poweredLabel setBackgroundColor:[UIColor clearColor]];
        [poweredLabel setFont:[UIFont fontWithName: LIGHT_FONT size: 16.0f]];
        [view addSubview:poweredLabel];
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(poweredLabel.frame.origin.x + 80, poweredLabel.frame.origin.y - 21.5, 100, 45)];
        [logo setImage:[[UIImage imageNamed:@"wavelink-grayscale.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        logo.tintColor = [UIColor colorFromHexCode:@"f5f5f5"];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [view addSubview:logo];
        
        view.backgroundColor = cell.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:view];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        [bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [bgImageView setClipsToBounds:YES];
        [bgImageView setImage:[UIImage imageNamed:@"backgroundA.png"]];
        [bgView addSubview:bgImageView];
        cell.backgroundView = bgView;
        
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
    if(indexPath.section == 2) {
        return 200;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        selectedRow = indexPath.row;
        NSDictionary* menuItem = [menuData objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:[menuItem objectForKey:@"segue"] sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"urlSegue"]){
        UrlViewController *dest = (UrlViewController *)[segue destinationViewController];
        NSDictionary* menuItem = [menuData objectAtIndex:selectedRow];
        dest.url = [NSURL URLWithString:[menuItem objectForKey:@"url"]];
        dest.title = [menuItem objectForKey:@"name"];
        dest.image = [menuItem objectForKey:@"icon"];
    }
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: actionlist
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SpecialsViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SpecialsViewController.h"
#import "ShowroomViewController.h"
#import "specialsCell.h"
#import "Common.h"

#import "UIColor+FlatUI.h"

@implementation SpecialsViewController
@synthesize specialsData;

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
    self.tableView.separatorColor = [UIColor colorFromHexCode:@"f5f5f5"];
    
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
    
    specialsData = [@[
                      @{ @"title" : @"The Winter Event", @"description" : @"Tis the season for new vehicle special offers!", @"photo" : @"winter-event.jpg", @"segue" : @"specialSegue" },
                      @{ @"title" : @"National Pre-Owned Specials", @"description" : @"Learn more about the Certified Pre-Owned Specials!", @"photo" : @"pre-owned-special.jpeg", @"segue" : @"specialSegue" },
                      @{ @"title" : @"The 2015 CLS-Class", @"description" : @"Introducing the latest edition of the 4 door coupe that started it all!", @"photo" : @"2015-cls-class.jpg", @"segue" : @"specialSegue" }
                      ] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Specials page" forKey:kGAIScreenName] build]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return [specialsData count];
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:@"Special Offers" withIcon:[UIImage imageNamed:@"specials.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        static NSString *specialsCellIdentifier = @"specialsCell";
        specialsCell *cell = (specialsCell *)[tableView dequeueReusableCellWithIdentifier:specialsCellIdentifier];
        if (cell == nil){ cell = [[specialsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:specialsCellIdentifier]; }
        
        NSDictionary* specialsItem = [specialsData objectAtIndex:indexPath.row];
        [cell.backgroundImageView setImage:[UIImage imageNamed:[specialsItem objectForKey:@"photo"]]];
        [cell.titleLabel setText:[specialsItem objectForKey:@"title"]];
        [cell.descriptionLabel setText:[specialsItem objectForKey:@"description"]];
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
        return 150;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        [self performSegueWithIdentifier:@"showroomSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showroomSegue"]){
        ShowroomViewController *dest = (ShowroomViewController *)[segue destinationViewController];
    }
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: actionlist
}

@end

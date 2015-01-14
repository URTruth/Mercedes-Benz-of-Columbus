//
//  HomeViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 12/1/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "HomeViewController.h"
#import "contactViewController.h"
#import "locationViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-65,0,0,0);
    self.navigationItem.hidesBackButton = YES;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName: @"AvenirNext-DemiBold" size: 14.0f]} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButton;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *navBtnImage = [UIImage imageNamed:@"nav.png"];
    [navBtn setBackgroundImage:navBtnImage forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(navButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    navBtn.frame = CGRectMake(0, 0, 21, 21);
    UIBarButtonItem *navButton = [[UIBarButtonItem alloc] initWithCustomView:navBtn] ;
    self.tabBarController.navigationItem.rightBarButtonItem = navButton;
    self.navigationItem.rightBarButtonItem = navButton;
}

- (void)viewDidAppear:(BOOL)animated {    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blankCell"];
    //if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.row == 0) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
        [bgImage setImage:[UIImage imageNamed:@"montage.png"]];
        [bgImage setContentMode:UIViewContentModeScaleAspectFill];
        [bgImage setClipsToBounds:YES];
        [cell addSubview:bgImage];
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, -22, 200, 150)];
        [logo setImage:[UIImage imageNamed:@"logo-tagline-white.png"]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [cell addSubview:logo];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startButtonClicked:)];
        [tapRecognizer setNumberOfTouchesRequired:1]; [tapRecognizer setDelegate:self];
        cell.userInteractionEnabled = YES; [cell addGestureRecognizer:tapRecognizer];
    }
    
    int padding = 10;
    if(indexPath.row == 9) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        [bgImage setImage:[UIImage imageNamed:@"pre-owned-special.jpeg"]];
        [bgImage setContentMode:UIViewContentModeScaleAspectFill];
        [bgImage setClipsToBounds:YES];
        [cell addSubview:bgImage];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 300, 16)];
        [title setText:@"National Pre-Owned Specials"];
        [title setFont:[UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16]];
        [title setTextColor:[UIColor asbestosColor]];
        [cell addSubview:title];
        
        UILabel * description = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding + title.frame.size.height, 300, 10)];
        [description setText:@"Learn more about the Certified Pre-Owned Specials!"];
        [description setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:10]];
        [description setTextColor:[UIColor asbestosColor]];
        [cell addSubview:description];
    }
    if(indexPath.row == 10) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        [bgImage setImage:[UIImage imageNamed:@"winter-event.jpg"]];
        [bgImage setContentMode:UIViewContentModeScaleAspectFill];
        [bgImage setClipsToBounds:YES];
        [cell addSubview:bgImage];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 300, 16)];
        [title setText:@"The Winter Event"];
        [title setFont:[UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16]];
        [title setTextColor:[UIColor midnightBlueColor]];
        [cell addSubview:title];
        
        UILabel * description = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding + title.frame.size.height, 300, 10)];
        [description setText:@"Tis the season for new vehicle special offers!"];
        [description setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:10]];
        [description setTextColor:[UIColor midnightBlueColor]];
        [cell addSubview:description];
    }
    if(indexPath.row == 11) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        [bgImage setImage:[UIImage imageNamed:@"2015-cls-class.jpg"]];
        [bgImage setContentMode:UIViewContentModeScaleAspectFill];
        [bgImage setClipsToBounds:YES];
        [cell addSubview:bgImage];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 300, 16)];
        [title setText:@"The 2015 CLS-Class"];
        [title setFont:[UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16]];
        [title setTextColor:[UIColor asbestosColor]];
        [cell addSubview:title];
        
        UILabel * description = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding + title.frame.size.height, 300, 10)];
        [description setText:@"Introducing the latest edition of the 4 door coupe that started it all!"];
        [description setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:10]];
        [description setTextColor:[UIColor asbestosColor]];
        [cell addSubview:description];
    }
    if(indexPath.row > 0 && indexPath.row < 9) {
        cell.backgroundColor = [UIColor whiteColor];
        //cell.textLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - cell.textLabel.frame.origin.x/2, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        image.image = [UIImage imageNamed:@"startBG.png"];
        [image setContentMode:UIViewContentModeScaleAspectFill];
        [image setClipsToBounds:YES];
        [cell addSubview:image];
        cell.imageView.image = [UIImage imageNamed:@"startBG.png"];
    }
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 150, 45/2 - 7, 300, 16)];
    [text setTextColor:[UIColor asbestosColor]];
    [text setFont:[UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16]];
    [text setTextAlignment:UITextAlignmentCenter];
    [cell addSubview:text];
    if(indexPath.row == 1) {
        text.text = @"New Inventory";
    }
    if(indexPath.row == 2) {
        text.text = @"Used Inventory";
    }
    if(indexPath.row == 3) {
        text.text = @"Specials";
    }
    if(indexPath.row == 4) {
        text.text = @"Book a Service";
    }
    if(indexPath.row == 5) {
        text.text = @"Location & Hours";
    }
    if(indexPath.row == 6) {
        text.text = @"Find us";
    }
    if(indexPath.row == 7) {
        text.text = @"Contact us";
    }
    if(indexPath.row == 8) {
        text.text = @"Show us your car";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 122;
    }
    if(indexPath.row == 9) {
        return 150;
    }
    if(indexPath.row == 10) {
        return 150;
    }
    if(indexPath.row == 11) {
        return 150;
    }
    //if(indexPath.row > 3) {
        return 45;
    //}
    return 150;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 7) {
        [self performSegueWithIdentifier:@"contactSegue" sender:self];
    }
    if(indexPath.row == 5) {
        [self performSegueWithIdentifier:@"contactSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"contactSegue"]){
        contactViewController *dest = (contactViewController *)[segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"locationSegue"]){
        locationViewController *dest = (locationViewController *)[segue destinationViewController];
    }
}

- (IBAction)startButtonClicked:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"startSegue" sender:self];
}

- (IBAction)navButtonClicked:(id)sender {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end

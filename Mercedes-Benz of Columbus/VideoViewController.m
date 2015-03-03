//
//  VideoViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/25/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "VideoViewController.h"
#import "videoCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize type;
@synthesize videoData;

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
    
}

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Showroom page" forKey:kGAIScreenName] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return 1;
        case 3: return 1;
        case 4: return 1;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:@"Video" withIcon:[UIImage imageNamed:@"video.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        static NSString *videoCellIdentifier = @"vehicleCell";
        videoCell *cell = (videoCell *)[tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
        if (cell == nil){ cell = [[videoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoCellIdentifier];
            
            [cell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/videoseries?list=PLKgHYmJ8Qq3L2D2nQDxWJ6MCvzuBhLfRg&amp;hl=en_US%22"]]];
        }
        return cell;
    }
    
    if(indexPath.section == 2) {
        static NSString *videoCellIdentifier = @"vehicleCell";
        videoCell *cell = (videoCell *)[tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
        if (cell == nil){ cell = [[videoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoCellIdentifier];
            
            [cell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/videoseries?list=PLKgHYmJ8Qq3L3HAFoJH8I1QC_wTg398NW&amp;hl=en_US%22"]]];
        }
        return cell;
    }
    
    if(indexPath.section == 3) {
        static NSString *videoCellIdentifier = @"vehicleCell";
        videoCell *cell = (videoCell *)[tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
        if (cell == nil){ cell = [[videoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoCellIdentifier];
            
            [cell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/videoseries?list=PL07ECE44DD2A5B53E&amp;hl=en_US%22"]]];
        }
        return cell;
    }
    
    if(indexPath.section == 4) {
        static NSString *videoCellIdentifier = @"vehicleCell";
        videoCell *cell = (videoCell *)[tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
        if (cell == nil){ cell = [[videoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoCellIdentifier];
            
            [cell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/videoseries?list=PLKgHYmJ8Qq3L85RgK7_Gtha3e-EjVbGiP&amp;hl=en_US%22"]]];
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
        return 250;
    }
    if(indexPath.section == 2) {
        return 250;
    }
    if(indexPath.section == 3) {
        return 250;
    }
    if(indexPath.section == 4) {
        return 250;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == 1) {
//        NSDictionary* vehicleItem = [videoData objectAtIndex:indexPath.row];
//    }
}


- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: add actionsheet here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
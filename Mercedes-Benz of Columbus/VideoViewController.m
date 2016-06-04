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
#import "ProgressHUD.h"
#import "UIColor+FlatUI.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize videoData;

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
    
    [self refresh];
}

- (void)viewDidAppear:(BOOL)animated {
      id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
      [tracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Video page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    [ProgressHUD show:@"Loading.."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLKgHYmJ8Qq3L2D2nQDxWJ6MCvzuBhLfRg&maxResults=50&key=AIzaSyCBZQxAABrkDPOY4rPh0RpdURnp9bzueAw" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        videoData = responseObject;
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return [[videoData objectForKey:@"items"] count];
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
            //[cell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/videoseries?list=PLKgHYmJ8Qq3L2D2nQDxWJ6MCvzuBhLfRg&amp;hl=en_US%22"]]];
        }
        
        NSMutableArray* videos = [videoData objectForKey:@"items"];
        NSDictionary* video = [videos objectAtIndex:indexPath.row];
        NSDictionary* snippet = [video objectForKey:@"snippet"];
        NSDictionary* thumbnails = [snippet objectForKey:@"thumbnails"];
        NSString* title = [snippet objectForKey:@"title"];
        NSString* description = [snippet objectForKey:@"description"];
        NSDictionary* image = [thumbnails objectForKey:@"default"];
        
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"video.png"]];
        [cell.nameLabel setText:title];
        [cell.descriptionTextView setText:description];
        
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
        return 88;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        NSMutableArray* videos = [videoData objectForKey:@"items"];
        NSDictionary* video = [videos objectAtIndex:indexPath.row];
        NSDictionary* snippet = [video objectForKey:@"snippet"];
        NSDictionary* resourceId = [snippet objectForKey:@"resourceId"];
        PBYouTubeVideoViewController *viewController = [[PBYouTubeVideoViewController alloc] initWithVideoId:[resourceId objectForKey:@"videoId"]];
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:NULL];
    }
}

- (void)youTubeVideoViewController:(PBYouTubeVideoViewController *)viewController didReceiveEventNamed:(NSString *)eventName eventData:(NSString *)eventData {
    NSLog(eventData);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: add actionsheet here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
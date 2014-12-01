//
//  HomeViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 12/1/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    //self.view.backgroundColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 123, 70)];
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(6, -5, 120, 74)];
    navigationImage.image=[UIImage imageNamed:@"logo-tagline-white.png"];
    navigationImage.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -3, 123, 70)];
    [workaroundImageView addSubview:navigationImage];
    [titleView addSubview:workaroundImageView];
    self.navigationItem.titleView = titleView;
    self.tabBarController.navigationItem.titleView = titleView;
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *navBtnImage = [UIImage imageNamed:@"nav.png"];
    [navBtn setBackgroundImage:navBtnImage forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    navBtn.frame = CGRectMake(0, 0, 21, 21);
    UIBarButtonItem *navButton = [[UIBarButtonItem alloc] initWithCustomView:navBtn] ;
    self.tabBarController.navigationItem.rightBarButtonItem = navButton;
    self.navigationItem.rightBarButtonItem = navButton;
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blankCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
    if(indexPath.row == 0) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        [bgImage setImage:[UIImage imageNamed:@"pre-owned-special.jpeg"]];
        [bgImage setContentMode:UIViewContentModeScaleAspectFill];
        [cell addSubview:bgImage];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

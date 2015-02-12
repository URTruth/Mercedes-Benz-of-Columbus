//
//  AccountViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "AccountViewController.h"
#import "HomeViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"


@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize backgroundImage, carImage, shareImage,arrowImage;
@synthesize logOut, myCar, share;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 360, 600)];
    
    NSInteger viewcount= 4;
    for (int i = 0; i <viewcount; i++)
    {
        CGFloat y = i * self.view.frame.size.height;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y,                                                      self.view.frame.size.width, self .view.frame.size.height)];
        view.backgroundColor = [UIColor greenColor];
        [self.view addSubview:scrollview];
    }
    scrollview.contentSize = CGSizeMake(350, 180 *viewcount);
    
    
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
    
    [self.view addSubview:[Common headerWithTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"]]];
    
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 122, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"montage.png"]];
    [self.view addSubview:backgroundImage];
    

    logOut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logOut.backgroundColor = [UIColor clearColor];
    logOut.frame = CGRectMake(116, 530, 150, 50);
    logOut.layer.cornerRadius=8.0f;
    logOut.layer.masksToBounds=YES;
    [logOut setBackgroundColor:[UIColor clearColor]];
    logOut.layer.borderColor=[[UIColor clearColor]CGColor];
    logOut.layer.borderWidth= 1.0f;
    logOut.clipsToBounds = YES;
    logOut.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    [logOut setTitle:@"Log Out"
            forState:UIControlStateNormal];
    [logOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOut addTarget:self
               action:@selector(logOutAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [logOut setTag:1];
    [self.view addSubview:logOut];

    
    carImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 234, 20, 20)];
    [carImage setContentMode:UIViewContentModeScaleAspectFill];
    [carImage setImage:[UIImage imageNamed:@"car.png"]];
    [self.view addSubview:carImage];
    
    myCar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myCar.backgroundColor = [UIColor clearColor];
    myCar.frame = CGRectMake(60, 220, 300, 50);
    myCar.layer.cornerRadius=8.0f;
    myCar.layer.masksToBounds=YES;
    [myCar setBackgroundColor:[UIColor clearColor]];
    myCar.layer.borderColor=[[UIColor clearColor]CGColor];
    myCar.layer.borderWidth= 1.0f;
    myCar.clipsToBounds = YES;
    myCar.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    myCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [myCar setTitle:@"My Mercedes"
            forState:UIControlStateNormal];
    [myCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myCar addTarget:self
               action:@selector(myCarAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [myCar setTag:1];
    [self.view addSubview:myCar];
    
    arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(330, 230, 30, 30)];
    [arrowImage setContentMode:UIViewContentModeScaleAspectFill];
    [arrowImage setImage:[UIImage imageNamed:@"arrow.png"]];
    [self.view addSubview:arrowImage];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(60, 270, 330, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
    shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 285, 30, 30)];
    [shareImage setContentMode:UIViewContentModeScaleAspectFill];
    [shareImage setImage:[UIImage imageNamed:@"share.png"]];
    [self.view addSubview:shareImage];
    
    share = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    share.backgroundColor = [UIColor clearColor];
    share.frame = CGRectMake(60, 280, 300, 50);
    share.layer.cornerRadius=8.0f;
    share.layer.masksToBounds=YES;
    [share setBackgroundColor:[UIColor clearColor]];
    share.layer.borderColor=[[UIColor clearColor]CGColor];
    share.layer.borderWidth= 1.0f;
    share.clipsToBounds = YES;
    share.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    share.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [share setTitle:@"Share this App"
            forState:UIControlStateNormal];
    [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [share addTarget:self
               action:@selector(shareAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [share setTag:1];
    [self.view addSubview:share];

    arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(330, 290, 30, 30)];
    [arrowImage setContentMode:UIViewContentModeScaleAspectFill];
    [arrowImage setImage:[UIImage imageNamed:@"arrow.png"]];
    [self.view addSubview:arrowImage];
}

- (void) logOutAction:(UIButton *)paramSender{
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
}

- (void) myCarAction:(UIButton *)paramSender{
    [self performSegueWithIdentifier:@"mycarSegue" sender:self];
}

- (void) shareAction:(UIButton *)paramSender{
    [self performSegueWithIdentifier:@"shareSegue" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"logoutSegue"]){
        HomeViewController *dest = (HomeViewController *)[segue destinationViewController];
//    }else if([segue.identifier isEqualToString:@"accountSegue"]){
//        AccountViewController *dest = (AccountViewController *)[segue destinationViewController];
    }
}

@end

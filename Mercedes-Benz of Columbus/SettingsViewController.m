//
//  SettingsViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/6/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize backgroundImage, arrowImage;
@synthesize notifications, share, muteSound;
@synthesize specialOffer, serviceOffers, news;
@synthesize soundSwitch, serviceSwitch, specialSwitch, newsSwitch;


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
    
    [self.view addSubview:[Common headerWithTitle:@"Settings" withIcon:[UIImage imageNamed:@"account.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 122, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"montage.png"]];
    [self.view addSubview:backgroundImage];
    
    
    
    notifications = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    notifications.backgroundColor = [UIColor clearColor];
    notifications.frame = CGRectMake(30, 150, 300, 50);
    notifications.layer.cornerRadius=8.0f;
    notifications.layer.masksToBounds=YES;
    [notifications setBackgroundColor:[UIColor clearColor]];
    notifications.layer.borderColor=[[UIColor clearColor]CGColor];
    notifications.layer.borderWidth= 1.0f;
    notifications.clipsToBounds = YES;
    [notifications setTitle:@"Notification Settings"
            forState:UIControlStateNormal];
    notifications.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    notifications.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [notifications setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [notifications addTarget:self
               action:@selector(signInAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [notifications setTag:1];
    [self.view addSubview:notifications];
   
    arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(330, 160, 30, 30)];
    [arrowImage setContentMode:UIViewContentModeScaleAspectFill];
    [arrowImage setImage:[UIImage imageNamed:@"arrow.png"]];
    [self.view addSubview:arrowImage];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 200, 330, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];

    
    share = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    share.backgroundColor = [UIColor clearColor];
    share.frame = CGRectMake(30, 220, 300, 50);
    share.layer.cornerRadius=8.0f;
    share.layer.masksToBounds=YES;
    [share setBackgroundColor:[UIColor clearColor]];
    share.layer.borderColor=[[UIColor clearColor]CGColor];
    share.layer.borderWidth= 1.0f;
    share.clipsToBounds = YES;
    [share setTitle:@"Share Settings"
                   forState:UIControlStateNormal];
    share.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    share.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [share addTarget:self
                      action:@selector(signInAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [share setTag:1];
    [self.view addSubview:share];
    
    arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(330, 230, 30, 30)];
    [arrowImage setContentMode:UIViewContentModeScaleAspectFill];
    [arrowImage setImage:[UIImage imageNamed:@"arrow.png"]];
    [self.view addSubview:arrowImage];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(30, 270, 330, 1)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView2];

    
    muteSound = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    muteSound.frame = CGRectMake(30, 290, 300, 50);
    muteSound.layer.cornerRadius=8.0f;
    muteSound.layer.masksToBounds=YES;
    [muteSound setBackgroundColor:[UIColor clearColor]];
    muteSound.layer.borderColor=[[UIColor clearColor]CGColor];
    muteSound.layer.borderWidth= 1.0f;
    muteSound.clipsToBounds = YES;
    [muteSound setTitle:@"Mute Sound"
                    forState:UIControlStateNormal];
    muteSound.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    muteSound.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [muteSound setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [muteSound addTarget:self
                       action:@selector(forgotPasswordAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [muteSound setTag:1];
    [self.view addSubview:muteSound];
    
    
    //frame for the switch
    CGRect myFrame = CGRectMake(300, 300, 30, 30);
    self.soundSwitch = [[UISwitch alloc] initWithFrame:myFrame];
    [self.soundSwitch setOn:YES];
    [self.soundSwitch addTarget:self
                      action:@selector(switchIsChanged:)
            forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.soundSwitch];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(30, 340, 330, 1)];
    lineView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView3];

    
    specialOffer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    specialOffer.frame = CGRectMake(30, 360, 300, 50);
    specialOffer.layer.cornerRadius=8.0f;
    specialOffer.layer.masksToBounds=YES;
    [specialOffer setBackgroundColor:[UIColor clearColor]];
    specialOffer.layer.borderColor=[[UIColor clearColor]CGColor];
    specialOffer.layer.borderWidth= 1.0f;
    specialOffer.clipsToBounds = YES;
    [specialOffer setTitle:@"Special Offers"
            forState:UIControlStateNormal];
    specialOffer.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    specialOffer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [specialOffer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [specialOffer addTarget:self
               action:@selector(signUpAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [specialOffer setTag:1];
    [self.view addSubview:specialOffer];
    
    
    //frame for the switch
    CGRect myFrame2 = CGRectMake(300, 370, 30, 30);
    self.specialSwitch = [[UISwitch alloc] initWithFrame:myFrame2];
    [self.specialSwitch setOn:YES];
    [self.specialSwitch addTarget:self
                         action:@selector(switchIsChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.specialSwitch];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(30, 410, 330, 1)];
    lineView4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView4];

    
    serviceOffers = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    serviceOffers.frame = CGRectMake(30, 430, 300, 50);
    serviceOffers.layer.cornerRadius=8.0f;
    serviceOffers.layer.masksToBounds=YES;
    [serviceOffers setBackgroundColor:[UIColor clearColor]];
    serviceOffers.layer.borderColor=[[UIColor clearColor]CGColor];
    serviceOffers.layer.borderWidth= 1.0f;
    serviceOffers.clipsToBounds = YES;
    [serviceOffers setTitle:@"Service Offers"
               forState:UIControlStateNormal];
    serviceOffers.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    serviceOffers.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [serviceOffers setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serviceOffers addTarget:self
                  action:@selector(forgotPasswordAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [serviceOffers setTag:1];
    [self.view addSubview:serviceOffers];
    
    
    //frame for the switch
    CGRect myFrame3 = CGRectMake(300, 440, 30, 30);
    self.serviceSwitch = [[UISwitch alloc] initWithFrame:myFrame3];
    [self.serviceSwitch setOn:YES];
    [self.serviceSwitch addTarget:self
                         action:@selector(switchIsChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.serviceSwitch];
    
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(30, 480, 330, 1)];
    lineView5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView5];

    
    news = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    news.frame = CGRectMake(30, 500, 300, 50);
    news.layer.cornerRadius=8.0f;
    news.layer.masksToBounds=YES;
    [news setBackgroundColor:[UIColor clearColor]];
    news.layer.borderColor=[[UIColor clearColor]CGColor];
    news.layer.borderWidth= 1.0f;
    news.clipsToBounds = YES;
    [news setTitle:@"News"
                  forState:UIControlStateNormal];
    news.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    news.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [news setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [news addTarget:self
                     action:@selector(signUpAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [news setTag:1];
    [self.view addSubview:news];

    
    //frame for the switch
    CGRect myFrame4 = CGRectMake(300, 510, 30, 30);
    self.newsSwitch = [[UISwitch alloc] initWithFrame:myFrame4];
    [self.newsSwitch setOn:YES];
    [self.newsSwitch addTarget:self
                         action:@selector(switchIsChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.newsSwitch];
    
    
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(30, 550, 330, 1)];
    lineView6.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView6];

}

//check if the switch is currently ON or OFF
- (void) switchIsChanged:(UISwitch *)paramSender{
    
    if ([paramSender isOn]){
        NSLog(@"The switch is turned on.");
    } else {
        NSLog(@"The switch is turned off.");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

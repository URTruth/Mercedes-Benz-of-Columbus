//
//  WarrantyViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/20/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "WarrantyViewController.h"
#import "Common.h"
#import "UIColor+FlatUI.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface WarrantyViewController ()

@end

@implementation WarrantyViewController
@synthesize backgroundImage;
@synthesize VIN;
@synthesize submit;

- (void)viewDidAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor blackColor];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Warranty page" forKey:kGAIScreenName] build]];
}

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
    
    [self.view addSubview:[Common headerWithTitle:@"My Warranty" withIcon:[UIImage imageNamed:@"warranty.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(168, 122, 20, 545)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"inside_blur.jpg"]];
    [self.view addSubview:backgroundImage];
    
    
    VIN = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 320, 50)];
    VIN.borderStyle = UITextBorderStyleRoundedRect;
    [VIN setBackgroundColor:[UIColor clearColor]];
    VIN.font = [UIFont systemFontOfSize:18];
    VIN.layer.cornerRadius=8.0f;
    VIN.layer.borderColor=[[UIColor whiteColor]CGColor];
    VIN.layer.borderWidth= 1.0f;
    VIN.layer.masksToBounds=YES;
    UIColor *color5 = [UIColor whiteColor];
    VIN.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter VIN" attributes:@{NSForegroundColorAttributeName: color5}];
    VIN.autocorrectionType = UITextAutocorrectionTypeNo;
    VIN.keyboardType = UIKeyboardTypeDefault;
    VIN.textColor = [UIColor whiteColor];
    VIN.returnKeyType = UIReturnKeyDone;
    VIN.clearButtonMode = UITextFieldViewModeWhileEditing;
    VIN.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    VIN.delegate = self;
    [self.view addSubview:VIN];
    
    
    submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.backgroundColor = [UIColor clearColor];
    submit.frame = CGRectMake(260, 200, 100, 50);
    submit.layer.cornerRadius=8.0f;
    submit.layer.masksToBounds=YES;
    [submit setBackgroundColor:[UIColor clearColor]];
    submit.layer.borderColor=[[UIColor clearColor]CGColor];
    submit.layer.borderWidth= 1.0f;
    submit.clipsToBounds = YES;
    [submit setTitle:@"Submit"
            forState:UIControlStateNormal];
    submit.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self
               action:@selector(submitAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [submit setTag:1];
    [self.view addSubview:submit];


}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) submitAction:(UIButton *)paramSender{
   // [self performSegueWithIdentifier:@"doneSegue" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if([segue.identifier isEqualToString:@"doneSegue"]){
//        AccountViewController *dest = (AccountViewController *)[segue destinationViewController];
//    }
//}

@end

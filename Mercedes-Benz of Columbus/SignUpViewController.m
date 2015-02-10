//
//  SignUpViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/2/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SignUpViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize labelData;
@synthesize lastname,firstname,username,email,password;
@synthesize first,last, user, emailLabel, passwordLabel;

- (void)viewDidAppear:(BOOL)animated {
    // main view background color
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    CGRect myImageRect = CGRectMake( 10.0f, 25.0f, 350.0f, 500.0f);
//    UIImageView *myImage = [[UIImageView alloc]initWithFrame:myImageRect];
//    [myImage setImage:[UIImage imageNamed:@"montage.png"]];
    
//    labelData = [@[
//                   @{ @"first" : @"First Name:", @"last" : @"Last Name:", @"user" : @"Username:", @"emailLabel" : @"Email:", @"passwordLabel" : @"Password:"},
//                   @{ @"user" : @"Username", @"passwordLabel" : @"Password:"}
//
//              ] mutableCopy];
//    
//    
//    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 600)];
//    
//    NSInteger viewcount= 4;
//    for (int i = 0; i <viewcount; i++)
//    {
//        CGFloat y = i * self.view.frame.size.height;
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self .view.frame.size.height)];
//        view.backgroundColor = [UIColor greenColor];
//        [self.view addSubview:scrollview];
//    }
//    scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 170 *viewcount);
//    
//    self.navigationItem.backBarButtonItem = [[Common alloc] backButton];
//    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    CGRect frame = self.view.frame;
//    frame.size.height += 65;
//    self.view.frame = frame;
//    self.navigationItem.titleView = nil;
//    self.tabBarController.navigationItem.titleView = nil;
//    
//    [self.view addSubview:[[Common alloc] headerWithTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"]]];
//    
//    UIBarButtonItem *optionsButton = [[Common alloc] optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
//    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
//    self.navigationItem.rightBarButtonItem = optionsButton;
//
//    // Gray background
//    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 58, [UIScreen mainScreen].bounds.size.width, 900)];
//    [centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    centerView.backgroundColor = [UIColor colorFromHexCode:@"dfdfdf"];
//    [scrollview addSubview:centerView];
//    
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Sign Up", @"Sign In", nil]];
//    segmentedControl.frame = CGRectMake(95, 100, 250, 50);
//    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//    segmentedControl.selectedSegmentIndex = 0;
//    segmentedControl.tintColor = [UIColor grayColor];
//    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName: SEMI_BOLD_FONT size: 18.0f] forKey:NSFontAttributeName];
//    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
//    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
//    [centerView addSubview:segmentedControl];
//    
//    NSDictionary* labelItem = [labelData objectAtIndex:0];
//    
//    first = [[UILabel alloc]initWithFrame:CGRectMake(10, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 60, [UIScreen mainScreen].bounds.size.width - 20, 15)];
//    first.backgroundColor = [UIColor clearColor];
//    first.clipsToBounds = YES;
//    first.text = [labelItem objectForKey:@"first"] ;
//    [first setTextAlignment: UITextAlignmentLeft];
//    [first setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
//    first.textColor = [UIColor colorFromHexCode:@"353535"];
//    [centerView addSubview:first];
//    
//    firstname = [[UITextField alloc]initWithFrame:CGRectMake(95, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 40, [UIScreen mainScreen].bounds.size.width - 125, 50)];
//    //firstname = [[UITextField alloc] initWithFrame:CGRectMake(95, 190, 250, 50)];
//    firstname.borderStyle = UITextBorderStyleRoundedRect;
//    firstname.font = [UIFont systemFontOfSize:15];
//    firstname.placeholder = @"first name";
//    firstname.autocorrectionType = UITextAutocorrectionTypeNo;
//    firstname.keyboardType = UIKeyboardTypeDefault;
//    firstname.returnKeyType = UIReturnKeyDone;
//    firstname.clearButtonMode = UITextFieldViewModeWhileEditing;
//    firstname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    firstname.delegate = self;
//    [centerView addSubview:firstname];
//    
//    last = [[UILabel alloc]initWithFrame:CGRectMake(10, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 110, [UIScreen mainScreen].bounds.size.width - 20, 15)];
//    last.backgroundColor = [UIColor clearColor];
//    last.clipsToBounds = YES;
//    last.text = [labelItem objectForKey:@"last"] ;
//    //last.text = @"Last Name:*";
//    [last setTextAlignment: UITextAlignmentLeft];
//    [last setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
//    last.textColor=[UIColor colorFromHexCode:@"353535"];
//    [centerView addSubview:last];
//    
//    lastname = [[UITextField alloc] initWithFrame:CGRectMake(95, 240, 250, 50)];
//    lastname.borderStyle = UITextBorderStyleRoundedRect;
//    lastname.font = [UIFont systemFontOfSize:15];
//    lastname.placeholder = @"last name";
//    lastname.autocorrectionType = UITextAutocorrectionTypeNo;
//    lastname.keyboardType = UIKeyboardTypeDefault;
//    lastname.returnKeyType = UIReturnKeyDone;
//    lastname.clearButtonMode = UITextFieldViewModeWhileEditing;
//    lastname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    lastname.delegate = self;
//    [centerView addSubview:lastname];
//    
//    user = [[UILabel alloc]initWithFrame:CGRectMake(10, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 160, [UIScreen mainScreen].bounds.size.width - 20, 15)];
//    user.backgroundColor = [UIColor clearColor];
//    user.clipsToBounds = YES;
//    user.text = [labelItem objectForKey:@"user"] ;
//   // user.text = @"Username:*";
//    [user setTextAlignment: UITextAlignmentLeft];
//    [user setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
//    user.textColor=[UIColor colorFromHexCode:@"353535"];
//    [centerView addSubview:user];
//    
//    username = [[UITextField alloc] initWithFrame:CGRectMake(95, 290, 250, 50)];
//    username.borderStyle = UITextBorderStyleRoundedRect;
//    username.font = [UIFont systemFontOfSize:15];
//    username.placeholder = @"username";
//    username.autocorrectionType = UITextAutocorrectionTypeNo;
//    username.keyboardType = UIKeyboardTypeDefault;
//    username.returnKeyType = UIReturnKeyDone;
//    username.clearButtonMode = UITextFieldViewModeWhileEditing;
//    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    username.delegate = self;
//    [centerView addSubview:username];
//    
//    emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 160, [UIScreen mainScreen].bounds.size.width - 20, 15)];
//    emailLabel.backgroundColor = [UIColor clearColor];
//    emailLabel.frame = CGRectMake(10, 340, 100, 50);
//    emailLabel.clipsToBounds = YES;
//    emailLabel.text = [labelItem objectForKey:@"emailLabel"] ;
//    //emailLabel.text = @"Email:*";
//    [emailLabel setTextAlignment: UITextAlignmentLeft];
//    [emailLabel setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
//    emailLabel.textColor=[UIColor colorFromHexCode:@"353535"];
//    [centerView addSubview:emailLabel];
//    
//    email = [[UITextField alloc] initWithFrame:CGRectMake(95, 340, 250, 50)];
//    email.borderStyle = UITextBorderStyleRoundedRect;
//    email.font = [UIFont systemFontOfSize:15];
//    email.placeholder = @"enter email";
//    email.autocorrectionType = UITextAutocorrectionTypeNo;
//    email.keyboardType = UIKeyboardTypeDefault;
//    email.returnKeyType = UIReturnKeyDone;
//    email.clearButtonMode = UITextFieldViewModeWhileEditing;
//    email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    email.delegate = self;
//    [centerView addSubview:email];
//    
//    passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 190, [UIScreen mainScreen].bounds.size.width - 20, 15)];
//    passwordLabel.backgroundColor = [UIColor clearColor];
//    passwordLabel.frame = CGRectMake(10, 390, 100, 50);
//    passwordLabel.clipsToBounds = YES;
//    passwordLabel.text = [labelItem objectForKey:@"passwordLabel"] ;
//    //passwordLabel.text = @"Password:*";
//    [passwordLabel setTextAlignment: UITextAlignmentLeft];
//    [passwordLabel setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
//    passwordLabel.textColor=[UIColor colorFromHexCode:@"353535"];
//    [centerView addSubview:passwordLabel];
//
//    password = [[UITextField alloc] initWithFrame:CGRectMake(95, 390, 250, 50)];
//    password.borderStyle = UITextBorderStyleRoundedRect;
//    password.font = [UIFont systemFontOfSize:15];
//    password.placeholder = @"at least 8 characters";
//    password.autocorrectionType = UITextAutocorrectionTypeNo;
//    password.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    password.returnKeyType = UIReturnKeyDone;
//    password.clearButtonMode = UITextFieldViewModeWhileEditing;
//    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    password.delegate = self;
//    [centerView addSubview:password];
//    
//    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn2.backgroundColor = [UIColor colorWithRed:50/255.0f green:70/255.0f blue:255/255.0f alpha:1.0f]; //2980B9
//    btn2.frame = CGRectMake(120, 385, 100, 40);
//    btn2.clipsToBounds = YES;
//    btn2.layer.cornerRadius = 3;
//    btn2.layer.shadowOffset = CGSizeMake(1, -2);
//    btn2.layer.shadowRadius = 4;
//    btn2.layer.shadowOpacity = 0.4;
//    [btn2 setTitle:@"Submit" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
//    [centerView addSubview:btn2];

}

- (void)valueChanged:(UISegmentedControl *)segment {
    NSDictionary* Item = [labelData objectAtIndex:segment.selectedSegmentIndex];
//    first.text = [Item objectForKey:@"first"];
//    last.text = [[Common alloc] formatPhoneNumber:[Item objectForKey:@"last"]];
//    departmentTelephoneLabel.text = [[Common alloc] formatPhoneNumber:[departmentItem objectForKey:@"phone"]];
//    mondayThroughFridayLabel.text = [@"Monday - Friday · " stringByAppendingString:[[Common alloc] formatTimeRangeWithStart:[departmentItem objectForKey:@"weekday_open_hour"] andEnd:[departmentItem objectForKey:@"weekday_close_hour"]]];
//    saturdayLabel.text = [@"Saturday · " stringByAppendingString:[[Common alloc] formatTimeRangeWithStart:[departmentItem objectForKey:@"saturday_open_hour"] andEnd:[departmentItem objectForKey:@"saturday_close_hour"]]];
//    sundayLabel.text = [@"Sunday · " stringByAppendingString:[[Common alloc] formatTimeRangeWithStart:[departmentItem objectForKey:@"sunday_open_hour"] andEnd:[departmentItem objectForKey:@"sunday_close_hour"]]];
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

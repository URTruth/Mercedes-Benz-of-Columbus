//
//  SignUpViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SignUpViewController.h"
#import "Common.h"
#import "UIColor+FlatUI.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize backgroundImage;
@synthesize username;
@synthesize password;
@synthesize passwordReEnter;
@synthesize email;
@synthesize firstname, lastname;
@synthesize doneButton;
@synthesize signUpLabel;

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
    
    
    self.navigationItem.backBarButtonItem = [[Common alloc] backButton];
    
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
    
    [self.view addSubview:[[Common alloc] headerWithTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"]]];
    
    
    UIBarButtonItem *optionsButton = [[Common alloc] optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 122, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"montage.png"]];
    [self.view addSubview:backgroundImage];

    
    signUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 140, 200, 50)];
    signUpLabel.text = @"Create an Account";
    signUpLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    signUpLabel.shadowColor = [UIColor clearColor];
    signUpLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:signUpLabel];
    
    
    firstname = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, 150, 50)];
    firstname.borderStyle = UITextBorderStyleRoundedRect;
    firstname.font = [UIFont systemFontOfSize:18];
    firstname.layer.cornerRadius=8.0f;
    firstname.layer.masksToBounds=YES;
    [firstname setBackgroundColor:[UIColor clearColor]];
    firstname.layer.borderColor=[[UIColor whiteColor]CGColor];
    firstname.layer.borderWidth= 1.0f;
    UIColor *color = [UIColor whiteColor];
    firstname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"first name" attributes:@{NSForegroundColorAttributeName: color}];
    firstname.autocorrectionType = UITextAutocorrectionTypeNo;
    firstname.keyboardType = UIKeyboardTypeDefault;
    firstname.textColor = [UIColor whiteColor];
    firstname.returnKeyType = UIReturnKeyDone;
    firstname.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    firstname.delegate = self;
    [self.view addSubview:firstname];
    
    
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(200, 200, 150, 50)];
    lastname.borderStyle = UITextBorderStyleRoundedRect;
    lastname.font = [UIFont systemFontOfSize:18];
    lastname.layer.cornerRadius=8.0f;
    lastname.layer.masksToBounds=YES;
    [lastname setBackgroundColor:[UIColor clearColor]];
    lastname.layer.borderColor=[[UIColor whiteColor]CGColor];
    lastname.layer.borderWidth= 1.0f;
    UIColor *color2 = [UIColor whiteColor];
    lastname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"last name" attributes:@{NSForegroundColorAttributeName: color2}];
    lastname.autocorrectionType = UITextAutocorrectionTypeNo;
    lastname.keyboardType = UIKeyboardTypeDefault;
    lastname.textColor = [UIColor whiteColor];
    lastname.returnKeyType = UIReturnKeyDone;
    lastname.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    lastname.delegate = self;
    [self.view addSubview:lastname];
    
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(30, 260, 320, 50)];
    username.borderStyle = UITextBorderStyleRoundedRect;
    username.font = [UIFont systemFontOfSize:18];
    username.layer.cornerRadius=8.0f;
    username.layer.masksToBounds=YES;
    [username setBackgroundColor:[UIColor clearColor]];
    username.layer.borderColor=[[UIColor whiteColor]CGColor];
    username.layer.borderWidth= 1.0f;
    UIColor *color3 = [UIColor whiteColor];
    username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter username" attributes:@{NSForegroundColorAttributeName: color3}];
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.keyboardType = UIKeyboardTypeDefault;
    username.textColor = [UIColor whiteColor];
    username.returnKeyType = UIReturnKeyDone;
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.delegate = self;
    [self.view addSubview:username];
    
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(30, 320, 320, 50)];
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.font = [UIFont systemFontOfSize:18];
    email.layer.cornerRadius=8.0f;
    email.layer.masksToBounds=YES;
    [email setBackgroundColor:[UIColor clearColor]];
    email.layer.borderColor=[[UIColor whiteColor]CGColor];
    email.layer.borderWidth= 1.0f;
    UIColor *color4 = [UIColor whiteColor];
    email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter email" attributes:@{NSForegroundColorAttributeName: color4}];
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    email.keyboardType = UIKeyboardTypeDefault;
    email.textColor = [UIColor whiteColor];
    email.returnKeyType = UIReturnKeyDone;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    email.delegate = self;
    [self.view addSubview:email];
    
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(30, 380, 320, 50)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    [password setBackgroundColor:[UIColor clearColor]];
    password.font = [UIFont systemFontOfSize:18];
    password.layer.cornerRadius=8.0f;
    password.layer.borderColor=[[UIColor whiteColor]CGColor];
    password.layer.borderWidth= 1.0f;
    password.layer.masksToBounds=YES;
    UIColor *color5 = [UIColor whiteColor];
    password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter password" attributes:@{NSForegroundColorAttributeName: color5}];
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.keyboardType = UIKeyboardTypeDefault;
    password.textColor = [UIColor whiteColor];
    password.returnKeyType = UIReturnKeyDone;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.delegate = self;
    [self.view addSubview:password];
    
    
    passwordReEnter = [[UITextField alloc] initWithFrame:CGRectMake(30, 440, 320, 50)];
    passwordReEnter.borderStyle = UITextBorderStyleRoundedRect;
    [passwordReEnter setBackgroundColor:[UIColor clearColor]];
    passwordReEnter.font = [UIFont systemFontOfSize:18];
    passwordReEnter.layer.cornerRadius=8.0f;
    passwordReEnter.layer.borderColor=[[UIColor whiteColor]CGColor];
    passwordReEnter.layer.borderWidth= 1.0f;
    passwordReEnter.layer.masksToBounds=YES;
    UIColor *color6 = [UIColor whiteColor];
    passwordReEnter.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"re-enter password" attributes:@{NSForegroundColorAttributeName: color6}];
    passwordReEnter.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordReEnter.keyboardType = UIKeyboardTypeDefault;
    passwordReEnter.textColor = [UIColor whiteColor];
    passwordReEnter.returnKeyType = UIReturnKeyDone;
    passwordReEnter.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordReEnter.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordReEnter.delegate = self;
    [self.view addSubview:passwordReEnter];
    
    doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.backgroundColor = [UIColor clearColor];
    doneButton.frame = CGRectMake(220, 520, 150, 50);
    doneButton.layer.cornerRadius=8.0f;
    doneButton.layer.masksToBounds=YES;
    [doneButton setBackgroundColor:[UIColor clearColor]];
    doneButton.layer.borderColor=[[UIColor clearColor]CGColor];
    doneButton.layer.borderWidth= 1.0f;
    doneButton.clipsToBounds = YES;
    doneButton.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    [doneButton setTitle:@"Sign Up"
            forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton addTarget:self
               action:@selector(doneAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTag:1];
    [self.view addSubview:doneButton];


}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)doneAction:(id)sender {
    // Send a synchronous request
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

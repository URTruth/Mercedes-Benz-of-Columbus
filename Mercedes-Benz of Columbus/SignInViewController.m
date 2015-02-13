//
//  SignInViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "AccountViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"


@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize backgroundImage;
@synthesize username, password;
@synthesize signIn, signUp, facebook, forgotPassword, submit;
@synthesize email;
@synthesize credentialsView;
@synthesize forgotView;
@synthesize tentView;
@synthesize signInLabel;

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
    
    [self.view addSubview:[Common headerWithTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    username.alpha = 0;
    email.alpha = 0;
    password.alpha = 0;
//   // self.fbLoginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
//    //fbLoginView.alpha = 0;
    forgotPassword.alpha = 0;

    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signInAction:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [tapRecognizer setDelegate:self];
    signIn.userInteractionEnabled = YES;
    [signIn addGestureRecognizer:tapRecognizer];

    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordAction::)];
    forgotPassword.userInteractionEnabled = YES;
    [forgotPassword addGestureRecognizer:tapRecognizer];
    
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 122, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"montage.png"]];
    [self.view addSubview:backgroundImage];
    
    
    signInLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 200, 250, 50)];
    signInLabel.text = @"Sign in to your Account";
    signInLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    signInLabel.shadowColor = [UIColor clearColor];
    signInLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:signInLabel];
    
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(30, 280, 320, 50)];
    username.borderStyle = UITextBorderStyleRoundedRect;
    username.font = [UIFont systemFontOfSize:18];
    username.layer.cornerRadius=8.0f;
    username.layer.masksToBounds=YES;
    [username setBackgroundColor:[UIColor clearColor]];
    username.layer.borderColor=[[UIColor whiteColor]CGColor];
    username.layer.borderWidth= 1.0f;
    UIColor *color = [UIColor whiteColor];
    username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter username" attributes:@{NSForegroundColorAttributeName: color}];
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.keyboardType = UIKeyboardTypeDefault;
    username.textColor = [UIColor whiteColor];
    username.returnKeyType = UIReturnKeyDone;
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.delegate = self;
    [self.view addSubview:username];
    
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(30, 345, 320, 50)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    [password setBackgroundColor:[UIColor clearColor]];
    password.font = [UIFont systemFontOfSize:18];
    password.layer.cornerRadius=8.0f;
    password.layer.borderColor=[[UIColor whiteColor]CGColor];
    password.layer.borderWidth= 1.0f;
    password.layer.masksToBounds=YES;
    UIColor *color2 = [UIColor whiteColor];
    password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter password" attributes:@{NSForegroundColorAttributeName: color2}];
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.keyboardType = UIKeyboardTypeDefault;
    password.textColor = [UIColor whiteColor];
    password.returnKeyType = UIReturnKeyDone;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.delegate = self;
    [self.view addSubview:password];
    
    signIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signIn.backgroundColor = [UIColor clearColor];
    signIn.frame = CGRectMake(260, 430, 100, 50);
    signIn.layer.cornerRadius=8.0f;
    signIn.layer.masksToBounds=YES;
    [signIn setBackgroundColor:[UIColor clearColor]];
    signIn.layer.borderColor=[[UIColor clearColor]CGColor];
    signIn.layer.borderWidth= 1.0f;
    signIn.clipsToBounds = YES;
    [signIn setTitle:@"Sign In"
            forState:UIControlStateNormal];
    signIn.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    
    [signIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signIn addTarget:self
               action:@selector(signInAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [signIn setTag:1];
    [self.view addSubview:signIn];
    
        facebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage *buttonImage = [UIImage imageNamed:@"facebook-login.png"];
        [facebook setBackgroundImage:buttonImage forState:UIControlStateNormal];
        facebook.frame = CGRectMake(90, 500, 200, 50);
        facebook.layer.cornerRadius=8.0f;
        facebook.layer.masksToBounds=YES;
        [facebook setBackgroundColor:[UIColor clearColor]];
        facebook.layer.borderColor=[[UIColor clearColor]CGColor];
        facebook.layer.borderWidth= 1.0f;
        facebook.clipsToBounds = YES;
        [facebook addTarget:self
                action:@selector(facebookAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [facebook setTag:1];
        [self.view addSubview:facebook];
    
    
    forgotPassword = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    forgotPassword.frame = CGRectMake(25, 405, 150, 30);
    forgotPassword.layer.cornerRadius=8.0f;
    forgotPassword.layer.masksToBounds=YES;
    [forgotPassword setBackgroundColor:[UIColor clearColor]];
    forgotPassword.layer.borderColor=[[UIColor clearColor]CGColor];
    forgotPassword.layer.borderWidth= 1.0f;
    forgotPassword.clipsToBounds = YES;
    [forgotPassword setTitle:@"Forgot Password?"
                    forState:UIControlStateNormal];
    
    [forgotPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgotPassword addTarget:self
                       action:@selector(forgotPasswordAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [forgotPassword setTag:1];
    [self.view addSubview:forgotPassword];
    
    signUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUp.frame = CGRectMake(260, 130, 100, 50);
    signUp.layer.cornerRadius=8.0f;
    signUp.layer.masksToBounds=YES;
    [signUp setBackgroundColor:[UIColor clearColor]];
    signUp.layer.borderColor=[[UIColor clearColor]CGColor];
    signUp.layer.borderWidth= 1.0f;
    signUp.clipsToBounds = YES;
    [signUp setTitle:@"Sign Up"
            forState:UIControlStateNormal];
    signUp.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    [signUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signUp addTarget:self
               action:@selector(signUpAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [signUp setTag:1];
    [self.view addSubview:signUp];
    
}



- (void) signInAction:(UIButton *)paramSender{
    [self performSegueWithIdentifier:@"accountSegue" sender:self];
}

- (void) signUpAction:(UIButton *)paramSender{
     [self performSegueWithIdentifier:@"signUpSegue" sender:self];
    
}

- (void) forgotPasswordAction:(UIButton *)paramSender{

    email = [[UITextField alloc] initWithFrame:CGRectMake(30, 300, 320, 50)];
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
    
    submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.backgroundColor = [UIColor clearColor];
    submit.frame = CGRectMake(260, 380, 100, 50);
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
               action:@selector(signInAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [submit setTag:1];
    [self.view addSubview:submit];
    
     [email becomeFirstResponder];

        [UIView animateWithDuration:0.0 animations:^{
            email.alpha = 1.0;
            username.alpha = 0.0;
            password.alpha = 0.0;
            forgotPassword.alpha = 0.0;
            signIn.alpha = 0.0;
            facebook.alpha = 0.0;
            
        }];
    
    }


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"signUpSegue"]){
        SignUpViewController *dest = (SignUpViewController *)[segue destinationViewController];
    }else if([segue.identifier isEqualToString:@"accountSegue"]){
        AccountViewController *dest = (AccountViewController *)[segue destinationViewController];
}
}

@end

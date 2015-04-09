//
//  SignInViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SignInViewController.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "AccountViewController.h"
#import "User.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"
#import "ACSimpleKeychain.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "ProgressHUD.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize backgroundView;
@synthesize fbLoginView;
@synthesize twitterLoginButton;
@synthesize digitsButton;
@synthesize credentialsView;
@synthesize forgotView;
@synthesize tentView;
@synthesize signInLabel;

- (void)viewDidAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.view addSubview:backgroundView];
    
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
    
    [self.view addSubview:[Common headerWithTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"] withBackground:[UIImage imageNamed:@"backgroundB.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    fbLoginView = [[FBLoginView alloc] initWithFrame:CGRectMake(20, 145, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    fbLoginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    fbLoginView.delegate = self;
    [self.view addSubview:fbLoginView];
    
    twitterLoginButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) { [self handleTwitterResponse:session error:error]; }];
    [twitterLoginButton setFrame:CGRectMake(20, fbLoginView.frame.origin.y + fbLoginView.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [self.view addSubview:twitterLoginButton];
    
    digitsButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) { [self handleDigitsResponse:session error:error]; }];
    digitsButton.frame = CGRectMake(20, twitterLoginButton.frame.origin.y + twitterLoginButton.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, 45);
    [self.view addSubview:digitsButton];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
 
}
 
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
 
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
     if (![self isUser:cachedUser equalToUser:user]) {
         cachedUser = user;
         [User sharedInstance].facebookId = user.id;
         [User sharedInstance].name = user.name;
         [User sharedInstance].email = [user objectForKey:@"email"];
         [User sharedInstance].photo = [[NSString alloc] initWithFormat:@"http://graph.facebook.com/%@/picture?type=large", user.id];
         [self login];
     }
}

- (BOOL)isUser:(id<FBGraphUser>)firstUser equalToUser:(id<FBGraphUser>)secondUser {
    return [firstUser.id isEqual:secondUser.id];
}

- (void)handleTwitterResponse:(TWTRSession *)session error:(NSError *)error {
    if (session) {
         NSLog(@"signed in as %@", [session userName]);
         TWTRShareEmailViewController* shareEmailViewController = [[TWTRShareEmailViewController alloc] initWithCompletion:^(NSString* email, NSError* error) { NSLog(@"Email %@, Error: %@", email, error);
             [User sharedInstance].twitterId = [session userID];
             [User sharedInstance].email = email;
             [self login];
         }];
         [self presentViewController:shareEmailViewController  animated:YES completion:nil];
    } else {
        NSLog(@"error: %@", [error localizedDescription]);
    }
}

- (void)handleDigitsResponse:(DGTSession *)session error:(NSError *)error {
    if (session) {
        NSLog(@"signed in as %@", [session phoneNumber]);
        if ([[Twitter sharedInstance] session]) {
            [User sharedInstance].digitsId = [session userID];
            [User sharedInstance].phone = [session phoneNumber];
            [self login];
        } else {
            // TODO: Handle user not signed in (e.g. attempt to log in or show an alert)
        }
    } else {
        NSLog(@"error: %@", [error localizedDescription]);
    }
}

- (void)login {
    [ProgressHUD show:@"Loading.."];
    [[User sharedInstance] login:^(BOOL isSuccess) {
        if(isSuccess) {
            AccountViewController *accountViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"accountViewController"];
            [self.navigationController setViewControllers:[NSArray arrayWithObject:accountViewController] animated:YES];
        } else {
            [self performSegueWithIdentifier:@"signUpSegue" sender:self];
        }
        [ProgressHUD dismiss];
    }];
}

- (void) forgotPasswordAction:(UIButton *)paramSender{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"signUpSegue"]){
        
    }else if([segue.identifier isEqualToString:@"accountSegue"]){
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
//#import "ACSimpleKeychain.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize backgroundView;
@synthesize emailTextBox;
@synthesize passwordTextBox;
@synthesize signIn, signUp, forgotPassword, submit;
//@synthesize fbLoginView;
//@synthesize twitterLoginButton;
@synthesize spinner;
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
    
    emailTextBox.alpha = 0;
    passwordTextBox.alpha = 0;
    forgotPassword.alpha = 0;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect spinnerFrame = spinner.frame;
    spinnerFrame.origin.x = self.view.frame.size.width / 2 - spinnerFrame.size.width / 2;
    spinnerFrame.origin.y = self.view.frame.size.height / 2 - spinnerFrame.size.height / 2;
    spinner.frame = spinnerFrame;
    [self.view addSubview:spinner];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signInAction:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [tapRecognizer setDelegate:self];
    signIn.userInteractionEnabled = YES;
    [signIn addGestureRecognizer:tapRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordAction::)];
    forgotPassword.userInteractionEnabled = YES;
    [forgotPassword addGestureRecognizer:tapRecognizer];
    
    //fbLoginView = [[FBLoginView alloc] initWithFrame:CGRectMake(20, 145, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    //fbLoginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    //fbLoginView.delegate = self;
    //[self.view addSubview:fbLoginView];
    
    //twitterLoginButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) { [self handleTwitterResponse:session error:error]; }];
    //[twitterLoginButton setFrame:CGRectMake(20, fbLoginView.frame.origin.y + fbLoginView.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    //[self.view addSubview:twitterLoginButton];
    
    //emailTextBox = [Common textBoxWithPlaceholder:@"Enter email.." frame:CGRectMake(20, twitterLoginButton.frame.origin.y + twitterLoginButton.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, 45) target:self];
    //[self.view addSubview:emailTextBox];
    
    passwordTextBox = [Common textBoxWithPlaceholder:@"Enter password.." frame:CGRectMake(20, emailTextBox.frame.origin.y + emailTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, emailTextBox.frame.size.height) target:self];
    [self.view addSubview:passwordTextBox];
    
    signIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signIn.backgroundColor = [UIColor clearColor];
    signIn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, passwordTextBox.frame.origin.y + 50, 100, 50);
    signIn.layer.cornerRadius=8.0f;
    signIn.layer.masksToBounds=YES;
    [signIn setBackgroundColor:[UIColor clearColor]];
    signIn.layer.borderColor=[[UIColor clearColor]CGColor];
    signIn.layer.borderWidth= 1.0f;
    signIn.clipsToBounds = YES;
    [signIn setTitle:@"Sign In" forState:UIControlStateNormal];
    signIn.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    
    [signIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signIn addTarget:self
               action:@selector(signInAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [signIn setTag:1];
    [self.view addSubview:signIn];
    
    forgotPassword = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    forgotPassword.frame = CGRectMake(15, passwordTextBox.frame.origin.y + 59, 150, 30);
    forgotPassword.layer.cornerRadius=8.0f;
    forgotPassword.layer.masksToBounds=YES;
    [forgotPassword setBackgroundColor:[UIColor clearColor]];
    forgotPassword.layer.borderColor=[[UIColor clearColor]CGColor];
    forgotPassword.layer.borderWidth= 1.0f;
    forgotPassword.clipsToBounds = YES;
    [forgotPassword setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgotPassword addTarget:self action:@selector(forgotPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [forgotPassword setTag:1];
    [self.view addSubview:forgotPassword];
    
    signUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUp.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 66, 100, 50);
    signUp.layer.cornerRadius=8.0f;
    signUp.layer.masksToBounds=YES;
    [signUp setBackgroundColor:[UIColor clearColor]];
    signUp.layer.borderColor=[[UIColor clearColor]CGColor];
    signUp.layer.borderWidth= 1.0f;
    signUp.clipsToBounds = YES;
    [signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    signUp.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
    [signUp setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [signUp addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [signUp setTag:1];
    [self.view addSubview:signUp];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == emailTextBox) {
        [textField resignFirstResponder];
        [passwordTextBox becomeFirstResponder];
    } else if (textField == self.passwordTextBox) {
        [textField resignFirstResponder];
        [spinner startAnimating];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"email": emailTextBox.text, @"password": passwordTextBox.text, @"iOSdeviceToken":[User sharedInstance].deviceToken};
        [manager POST:[Common webServiceUrlWithPath:@"login.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *responseData = (NSDictionary*)responseObject;
            if ([[responseData objectForKey:@"authenticated"] isEqualToString:@"true"]){
                [User sharedInstance].userId = [responseData objectForKey:@"userId"];
                [User sharedInstance].email = [responseData objectForKey:@"email"];
                //ACSimpleKeychain *keychain = [ACSimpleKeychain defaultKeychain];
                //if ([keychain storeUsername:appDelegate.email password:appDelegate.userId identifier:@"account" forService:@"Mercedes-Benz of Columbus"]) {
                //    NSLog(@"SAVED credentials for 'Mercedes-Benz of Columbus' credentials identifier 'account'");
                //}
                [self performSegueWithIdentifier:@"accountSegue" sender:self];
            }else{
                [Common showErrorMessageWithTitle:@"Oops! Login failed!" message:@"Please review your credentials." cancelButtonTitle:@"OK"];
            }
            [spinner stopAnimating];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
            [spinner stopAnimating];
        }];
    }
    /*
     else if (textField == self.emailTextBox) {
     [textField resignFirstResponder];
     
     [spinner startAnimating];
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     NSDictionary *parameters = @{@"email": emailTextBox.text };
     [manager POST:[Common webServiceUrlWithPath:@"forgot_password.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSDictionary *responseData = (NSDictionary*)responseObject;
     if ([[responseData objectForKey:@"response"] isEqualToString:@"success"]){
     [Common showErrorMessageWithTitle:@"Success!" message:@"Check your email to get your password." cancelButtonTitle:@"OK"];
     }else{
     [Common showErrorMessageWithTitle:[responseData objectForKey:@"response"] message:@"Please try again." cancelButtonTitle:@"OK"];
     }
     [spinner stopAnimating];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
     [spinner stopAnimating];
     }];
     }
     */
    
    return YES;
}

/*
 - (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
 
 }
 
 - (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
 
 }

 - (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
     if (![self isUser:cachedUser equalToUser:user]) {
         cachedUser = user;
         facebookID = user.id;
         facebookFirstName = user.first_name;
         facebookLastName = user.last_name;
         facebookEmail = [user objectForKey:@"email"];
         facebookProfilePicURL = [[NSString alloc] initWithFormat:@"http://graph.facebook.com/%@/picture?type=large", facebookID];
         
         [spinner startAnimating];
         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
         NSDictionary *parameters = @{@"facebookId": facebookID, @"iOSdeviceToken":appDelegate.dToken};
         [manager POST:[Common webServiceUrlWithPath:@"login_with_facebook.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseData = (NSDictionary*)responseObject;
             if ([[responseData objectForKey:@"authenticated"] isEqualToString:@"true"]){
                 appDelegate.userId = [responseData objectForKey:@"userId"];
                 appDelegate.email = [responseData objectForKey:@"email"];
                 ACSimpleKeychain *keychain = [ACSimpleKeychain defaultKeychain];
                 if ([keychain storeUsername:appDelegate.email password:appDelegate.userId identifier:@"account" forService:@"Mercedes-Benz of Columbus"]) {
                    NSLog(@"SAVED credentials for 'Mercedes-Benz of Columbus' credentials identifier 'account'");
                 }
                 
                 //UIViewController *vc = [self topMostController:[UIApplication sharedApplication].keyWindow.rootViewController];
                 //if([vc.restorationIdentifier isEqualToString:@"Login"]){
                    [self performSegueWithIdentifier:@"accountSegue" sender:self];
                 //}
             }else{
                [self performSegueWithIdentifier:@"signUpSegue" sender:self];
             }
             [spinner stopAnimating];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
             [spinner stopAnimating];
         }];
     }
 }

/*
- (void)handleTwitterResponse:(TWTRSession *)session error:(NSError *)error {
    if (session) {
        NSLog(@"signed in as %@", [session userName]);
        if ([[Twitter sharedInstance] session]) {
            
            [spinner startAnimating];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSDictionary *parameters = @{@"twitterId": [session userID], @"iOSdeviceToken":appDelegate.dToken};
            [manager POST:[Common webServiceUrlWithPath:@"login_with_twitter.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *responseData = (NSDictionary*)responseObject;
                if ([[responseData objectForKey:@"authenticated"] isEqualToString:@"true"]){
                    appDelegate.userId = [responseData objectForKey:@"userId"];
                    appDelegate.email = [responseData objectForKey:@"email"];
                    ACSimpleKeychain *keychain = [ACSimpleKeychain defaultKeychain];
                    if ([keychain storeUsername:appDelegate.email password:appDelegate.userId identifier:@"account" forService:@"Mercedes-Benz of Columbus"]) {
                        NSLog(@"SAVED credentials for 'Mercedes-Benz of Columbus' credentials identifier 'account'");
                    }
                    
                    //UIViewController *vc = [self topMostController:[UIApplication sharedApplication].keyWindow.rootViewController];
                    //if([vc.restorationIdentifier isEqualToString:@"Login"]){
                    [self performSegueWithIdentifier:@"accountSegue" sender:self];
                    //}
                }else{
                    [self performSegueWithIdentifier:@"signUpSegue" sender:self];
                }
                [spinner stopAnimating];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
                [spinner stopAnimating];
            }];
            
            /*
             TWTRShareEmailViewController* shareEmailViewController = [[TWTRShareEmailViewController alloc] initWithCompletion:^(NSString* email, NSError* error) { NSLog(@"Email %@, Error: %@", email, error); }];
             [self presentViewController:shareEmailViewController  animated:YES completion:nil];
             *
        } else {
            // TODO: Handle user not signed in (e.g. attempt to log in or show an alert)
        }
    } else {
        NSLog(@"error: %@", [error localizedDescription]);
    }
}
*/

- (void)loginWithEmail:(NSString *)email password:(NSString *)password facebookId:(NSString *)facebookId twitterId:(NSString *)twitterId iOSdeviceToken:(NSString *)iOSdeviceToken {
    [spinner startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": email, @"password": password, @"facebookId":facebookId, @"twitterId":twitterId, @"iOSdeviceToken":iOSdeviceToken};
    [manager POST:[Common webServiceUrlWithPath:@"login.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        if ([[responseData objectForKey:@"authenticated"] isEqualToString:@"true"]){
            [User sharedInstance].userId = [responseData objectForKey:@"userId"];
            [User sharedInstance].email = [responseData objectForKey:@"email"];
            //ACSimpleKeychain *keychain = [ACSimpleKeychain defaultKeychain];
            //if ([keychain storeUsername:appDelegate.email password:appDelegate.userId identifier:@"account" forService:@"Mercedes-Benz of Columbus"]) {
            //    NSLog(@"SAVED credentials for 'Mercedes-Benz of Columbus' credentials identifier 'account'");
            //}
            [self performSegueWithIdentifier:@"accountSegue" sender:self];
        }else{
            [Common showErrorMessageWithTitle:@"Oops! Login failed!" message:@"Please review your credentials." cancelButtonTitle:@"OK"];
        }
        [spinner stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
        [spinner stopAnimating];
    }];
}

/*
 - (BOOL)isUser:(id<FBGraphUser>)firstUser equalToUser:(id<FBGraphUser>)secondUser {
 return [firstUser.id isEqual:secondUser.id];
 }
 */

- (void) signInAction:(UIButton *)paramSender{
    [self performSegueWithIdentifier:@"accountSegue" sender:self];
}

- (void) signUpAction:(UIButton *)paramSender{
    [self performSegueWithIdentifier:@"signUpSegue" sender:self];
    
}

- (void) forgotPasswordAction:(UIButton *)paramSender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"signUpSegue"]){

    }else if([segue.identifier isEqualToString:@"accountSegue"]){
        
    }
}

@end
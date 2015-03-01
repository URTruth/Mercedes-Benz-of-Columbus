//
//  SignInViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SignInViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITextField *emailTextBox;
@property (nonatomic, strong) UITextField *passwordTextBox;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UIButton *signUp, *signIn, *forgotPassword, *submit;
@property (weak, nonatomic) IBOutlet UIView *credentialsView;
@property (weak, nonatomic) IBOutlet UIView *forgotView;
@property (strong, nonatomic) IBOutlet UIView *tentView;
@property (strong, nonatomic) IBOutlet UILabel *signInLabel;

@end

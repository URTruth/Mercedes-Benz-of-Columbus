//
//  SignUpViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic, strong) UIImageView *backgroundImage;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *passwordReEnter;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UIButton *signUp;
@property (strong, nonatomic) IBOutlet UILabel *signUpLabel;

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSString * password2;


@end

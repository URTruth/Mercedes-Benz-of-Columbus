//
//  SignUpViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/2/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray *labelData;

@property (nonatomic, strong) UITextField *firstname;
@property (nonatomic, strong) UITextField *lastname;
@property (nonatomic, strong) UITextField *username;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UITextField *password;

@property(nonatomic, strong) UILabel *first;
@property(nonatomic, strong) UILabel *last;
@property(nonatomic, strong) UILabel *user;
@property(nonatomic, strong) UILabel *emailLabel;
@property(nonatomic, strong) UILabel *passwordLabel;


@end

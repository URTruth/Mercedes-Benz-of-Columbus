//
//  SignUpViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FUIButton.h"
#import "VPImageCropperViewController.h"

@interface SignUpViewController : UIViewController<UIImagePickerControllerDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, UITextFieldDelegate, VPImageCropperDelegate>
{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *nameTextBox;
@property (strong, nonatomic) UITextField *emailTextBox;
@property (strong, nonatomic) UITextField *phoneTextBox;
@property (strong, nonatomic) UITextField *vinTextBox;
@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UIImageView *placeholderImageView;
@property (strong, nonatomic) FUIButton *searchButton;
@property (strong, nonatomic) FUIButton *signUpButton;

@end

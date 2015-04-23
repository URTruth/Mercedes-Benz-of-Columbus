//
//  AppointmentViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FUIButton.h"

@interface AppointmentViewController : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *selectionLabel;
@property (strong, nonatomic) FUIButton  *chooseButton;
@property (strong, nonatomic) UITextField *nameTextBox;
@property (strong, nonatomic) UITextField *emailTextBox;
@property (strong, nonatomic) UITextField *phoneTextBox;
@property (strong, nonatomic) UISegmentedControl *contactMethodChooser;
@property (strong, nonatomic) NSString *contactMethod;
@property (strong, nonatomic) UITextView *messageTextField;
@property (nonatomic, strong) NSArray *selectionListItems;
@property (nonatomic, strong) UIPickerView *selectionPicker;
@property (nonatomic, strong) FUIButton *submitButton;

@end


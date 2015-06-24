//
//  AppointmentViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "AppointmentViewController.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIColor+FlatUI.h"
#import "ProgressHUD.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController
@synthesize vin;
@synthesize backgroundView;
@synthesize scrollView;
@synthesize selection;
@synthesize selectionPicker;
@synthesize selectionLabel;
@synthesize chooseButton;
@synthesize nameTextBox;
@synthesize phoneTextBox;
@synthesize emailTextBox;
@synthesize vinTextBox;
@synthesize contactMethodChooser;
@synthesize contactMethod;
@synthesize messageTextField;
@synthesize selectionListItems;
@synthesize submitButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.view addSubview:backgroundView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1200);
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer: tapRec];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [Common navigationBarTintColor];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    [self.view addSubview:[Common headerWithTitle:@"Contact Us" withIcon:[UIImage imageNamed:@"appointment.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    int buttonHeight = 40;
    int textBoxHeight = 40;
    int chooseButtonWidth = 80;
    
    int selectionLabelFontSize = 20;
    selectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 145, [UIScreen mainScreen].bounds.size.width - chooseButtonWidth - 20, selectionLabelFontSize)];
    selectionLabel.backgroundColor = [UIColor clearColor];
    selectionLabel.clipsToBounds = YES;
    [selectionLabel setTextAlignment: UITextAlignmentLeft];
    [selectionLabel setFont:[UIFont fontWithName: BOLD_FONT size: selectionLabelFontSize]];
    selectionLabel.textColor = [UIColor colorFromHexCode:@"#353535"];
    [scrollView addSubview:selectionLabel];
    
    chooseButton = [Common buttonWithText:@"Choose" color:[UIColor sunflowerColor] frame:CGRectMake([UIScreen mainScreen].bounds.size.width - chooseButtonWidth - 20, 132, chooseButtonWidth, buttonHeight)];
    UITapGestureRecognizer *chooseTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTheInquiry:)];
    [chooseTapRecognizer setNumberOfTouchesRequired:1];
    [chooseTapRecognizer setDelegate:self];
    [chooseButton addGestureRecognizer:chooseTapRecognizer];
    [scrollView addSubview:chooseButton];
    
    nameTextBox = [Common textBoxWithPlaceholder:@"Enter name.." frame:CGRectMake(20, chooseButton.frame.origin.y + chooseButton.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:nameTextBox];
    
    emailTextBox = [Common textBoxWithPlaceholder:@"Enter email.. (Optional)" frame:CGRectMake(20, nameTextBox.frame.origin.y + nameTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:emailTextBox];
    
    phoneTextBox = [Common textBoxWithPlaceholder:@"Enter phone..  (Optional)" frame:CGRectMake(20, emailTextBox.frame.origin.y + emailTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:phoneTextBox];
    
    vinTextBox = [Common textBoxWithPlaceholder:@"Enter VIN.. (Optional)" frame:CGRectMake(20, phoneTextBox.frame.origin.y + phoneTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    if(vin && ![vin isEqualToString:@""]) {
        vinTextBox.text = vin;
    }
    [scrollView addSubview:vinTextBox];
    
    contactMethodChooser = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Phone", @"Email", nil]];
    contactMethodChooser.frame = CGRectMake(20, vinTextBox.frame.origin.y + vinTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, 30);
    contactMethodChooser.segmentedControlStyle = UISegmentedControlStyleBar;
    contactMethodChooser.selectedSegmentIndex = 0;
    contactMethodChooser.tintColor = [UIColor CustomGrayColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f] forKey:NSFontAttributeName];
    [contactMethodChooser setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [contactMethodChooser addTarget:self action:@selector(contactMethodChanged:) forControlEvents: UIControlEventValueChanged];
    [scrollView addSubview:contactMethodChooser];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, contactMethodChooser.frame.origin.y + contactMethodChooser.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [messageLabel setFont:[UIFont fontWithName:REGULAR_FONT size:14]];
    [messageLabel setTintColor:[UIColor colorFromHexCode:@"#353535"]];
    [messageLabel setText:@"What do you need? (Optional)"];
    [scrollView addSubview:messageLabel];
    
    messageTextField = [[UITextView alloc] initWithFrame:CGRectMake(20, messageLabel .frame.origin.y + messageLabel.frame.size.height + 5, [UIScreen mainScreen].bounds.size.width - 40, 200)];
    messageTextField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:15.0];
    messageTextField.layer.cornerRadius=8.0f;
    messageTextField.layer.masksToBounds=YES;
    [messageTextField setBackgroundColor:[UIColor CustomGrayColor]];
    messageTextField.layer.borderWidth= 0.0f;
    messageTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    messageTextField.keyboardType = UIKeyboardTypeDefault;
    messageTextField.textColor = [UIColor whiteColor];
    messageTextField.returnKeyType = UIReturnKeyDone;
    messageTextField.delegate = self;
    [scrollView addSubview:messageTextField];
    
    submitButton = [Common buttonWithText:@"Send" color:[UIColor turquoiseColor] frame:CGRectMake(20, messageTextField.frame.origin.y + messageTextField.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, buttonHeight)];
    [submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];
    
    selectionListItems = [[NSArray alloc] initWithObjects:
                     @"Test Drive Request",
                     @"Get ePrice",
                     @"Request More Info",
                     @"Lease / Finance Info",
                     @"Service & Parts Info",
                     @"Service Appointment",
                     @"General Request",
                     @"Other",
                     nil];
    
    [selectionLabel setText:selection];
    if(!selection || [selection isEqualToString:@""]) {
        selection = [selectionListItems objectAtIndex:0];
        [selectionLabel setText:[selectionListItems objectAtIndex:0]];
    }
    
    contactMethod = @"phone";
}

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Appointment page" forKey:kGAIScreenName] build]];
}

- (void) chooseTheInquiry:(UIButton *)paramSender{
    if(selectionPicker == nil){
        selectionPicker = [[UIPickerView alloc] init];
        selectionPicker.backgroundColor = [UIColor whiteColor];
        selectionPicker.dataSource = self;
        selectionPicker.delegate = self;
        selectionPicker.showsSelectionIndicator = YES;
        [self.view addSubview:selectionPicker];
    }
    
    CGRect screenRect = [self.view frame];
    CGSize pickerSize = [selectionPicker sizeThatFits:CGSizeZero];
    selectionPicker.frame = CGRectMake(0.0,
                                           screenRect.origin.y + screenRect.size.height - pickerSize.height,
                                           pickerSize.width,
                                           pickerSize.height);
    selectionPicker.hidden = NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [selectionListItems count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [selectionListItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [selectionLabel setText:[selectionListItems objectAtIndex:row]];
    selectionPicker.hidden=YES;
}

- (void)contactMethodChanged:(UISegmentedControl *)segment {
    switch(segment.selectedSegmentIndex) {
        case 0: contactMethod = @"phone"; break;
        case 1: contactMethod = @"email"; break;
        default: contactMethod = @"phone";
    }
}

- (void)submitButtonClicked:(id)sender {
    [self disableControls];
    [ProgressHUD show:@"Hey! We're validating..."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"name": nameTextBox.text, @"email": emailTextBox.text, @"phone": phoneTextBox.text, @"vin": vinTextBox.text, @"contact_method": contactMethod, @"type": selection, @"message": messageTextField.text };
    [manager POST:[Common webServiceUrlWithPath:@"save_inquiry.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        if ([[responseData objectForKey:@"response"] isEqualToString:@"SUCCESS"]){
            [ProgressHUD showSuccess:@"Success! You will be contacted shortly!"];
            [self performSegueWithIdentifier:@"homeSegue" sender:self];
        }else{
            [ProgressHUD dismiss];
            [Common showErrorMessageWithTitle:[responseData objectForKey:@"response"] message:@"Please retry." cancelButtonTitle:@"OK"];
        }
        [self enableControls];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
        [self enableControls];
    }];
}

- (void)disableControls {
    chooseButton.enabled = NO;
    vinTextBox.enabled = NO;
    nameTextBox.enabled = NO;
    emailTextBox.enabled = NO;
    phoneTextBox.enabled = NO;
    submitButton.enabled = NO;
    contactMethodChooser.enabled = NO;
    messageTextField.editable = NO;
}

- (void)enableControls {
    chooseButton.enabled = YES;
    vinTextBox.enabled = YES;
    nameTextBox.enabled = YES;
    emailTextBox.enabled = YES;
    phoneTextBox.enabled = YES;
    submitButton.enabled = YES;
    contactMethodChooser.enabled = YES;
    messageTextField.editable = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if (sender.frame.origin.y > 150)
    {
        [scrollView setContentOffset:CGPointMake(0, sender.frame.origin.y-150) animated:YES];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)sender
{
    if (sender.frame.origin.y > 150)
    {
        [scrollView setContentOffset:CGPointMake(0, sender.frame.origin.y-150) animated:YES];
    }
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)viewWillDisappear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
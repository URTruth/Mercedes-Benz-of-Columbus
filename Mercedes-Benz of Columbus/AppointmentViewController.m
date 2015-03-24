//
//  AppointmentViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "AppointmentViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController
@synthesize backgroundView;
@synthesize myButton;
@synthesize inquiry1;
@synthesize myCustomPicker;
@synthesize doneButton;
@synthesize isChecked, checkboxButton;
@synthesize phone;
@synthesize firstname,lastname, email, number;

- (void)viewDidAppear:(BOOL)animated {
    // main view background color
   // self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.view addSubview:backgroundView];
    
    
    //loads scroll view
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 360, 600)];
    
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
    
    [self.view addSubview:[Common headerWithTitle:@"Contact Us" withIcon:[UIImage imageNamed:@"appointment.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    //create a rounded rectangle type button
    myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.backgroundColor = [UIColor turquoiseColor];
    myButton.frame = CGRectMake(85, 55, 200, 40);
    myButton.clipsToBounds = YES;
    myButton.layer.cornerRadius = 3;
    myButton.layer.shadowOffset = CGSizeMake(1, -2);
    myButton.layer.shadowRadius = 4;
    myButton.layer.shadowOpacity = 0.4;
    [myButton setFont:[UIFont fontWithName: SEMI_BOLD_FONT  size: 15.0f]];
    myButton.tintColor = [UIColor colorFromHexCode:@"FFFFFF"];
    [myButton setTitle:@"Select your inquiry"
                   forState:UIControlStateNormal];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName: SEMI_BOLD_FONT size: 10.0f] forKey:NSFontAttributeName];
    [myButton addTarget:self
                      action:@selector(chooseTheInquiry:)
            forControlEvents:UIControlEventTouchUpInside];
    [myButton setTag:1];
    [scrollview addSubview:self.myButton];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label.backgroundColor = [UIColor clearColor]; //2980B9
    label.frame = CGRectMake(10, myButton.frame.origin.y + myButton.frame.size.height + 30, [UIScreen mainScreen].bounds.size.width - 20, 15);
    label.clipsToBounds = YES;
    label.text = @"Fields marked with an asterick(*) must be provided";
    [label setTextAlignment: UITextAlignmentLeft];
    [label setFont:[UIFont fontWithName: BOLD_FONT size: 10.0f]];
    label.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:label];
    
    //name label and textfields on gray view
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 0)];
    label1.backgroundColor = [UIColor clearColor]; //2980B9
    label1.frame = CGRectMake(10, label.frame.origin.y + label.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 50);
    label1.clipsToBounds = YES;
    label1.text = @"Name:*";
    [label1 setTextAlignment: UITextAlignmentLeft];
    [label1 setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    label1.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:label1];
    
    firstname = [[UITextField alloc] initWithFrame:CGRectMake(70, label.frame.origin.y + label.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    firstname.borderStyle = UITextBorderStyleRoundedRect;
    firstname.font = [UIFont systemFontOfSize:15];
    firstname.placeholder = @"first name";
    firstname.autocorrectionType = UITextAutocorrectionTypeNo;
    firstname.keyboardType = UIKeyboardTypeDefault;
    firstname.returnKeyType = UIReturnKeyDone;
    firstname.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    firstname.delegate = self;
    [scrollview addSubview:firstname];
    
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(70, firstname.frame.origin.y + firstname.frame.size.height + 15, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    lastname.borderStyle = UITextBorderStyleRoundedRect;
    lastname.font = [UIFont systemFontOfSize:15];
    lastname.placeholder = @"last name";
    lastname.autocorrectionType = UITextAutocorrectionTypeNo;
    lastname.keyboardType = UIKeyboardTypeDefault;
    lastname.returnKeyType = UIReturnKeyDone;
    lastname.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    lastname.delegate = self;
    [scrollview addSubview:lastname];
    
    
    //contact label and check buttons on gray view
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label2.backgroundColor = [UIColor clearColor]; //2980B9
    label2.frame = CGRectMake(10, lastname.frame.origin.y + lastname.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, 50);
    label2.clipsToBounds = YES;
    label2.text = @"Contact me by:";
    [label2 setTextAlignment: UITextAlignmentLeft];
    [label2 setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    label2.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:label2];
    
    //checkbox button and label for email option
    UIButton* checkBox = [[UIButton alloc] initWithFrame:CGRectMake(100, lastname.frame.origin.y + lastname.frame.size.height + 25, [UIScreen mainScreen].bounds.size.width - 20, 32)];
    [checkBox setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [checkBox addTarget:self action:@selector(checkBoxClicked:) forControlEvents: UIControlEventTouchUpInside];
    [checkBox setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [checkBox setImageEdgeInsets:UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0)];
    [scrollview addSubview:checkBox];
    
    UILabel * checkBoxlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    checkBoxlabel.backgroundColor = [UIColor clearColor]; //2980B9
    checkBoxlabel.frame = CGRectMake(155, lastname.frame.origin.y + lastname.frame.size.height + 25, [UIScreen mainScreen].bounds.size.width - 20, 32);
    checkBoxlabel.clipsToBounds = YES;
    checkBoxlabel.text = @"email";
    [checkBoxlabel setTextAlignment: UITextAlignmentLeft];
    [checkBoxlabel setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    checkBoxlabel.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:checkBoxlabel];
    
    UILabel * checkBoxlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    checkBoxlabel2.backgroundColor = [UIColor clearColor]; //2980B9
    checkBoxlabel2.frame = CGRectMake(255, lastname.frame.origin.y + lastname.frame.size.height + 25, [UIScreen mainScreen].bounds.size.width - 20, 32);
    checkBoxlabel2.clipsToBounds = YES;
    checkBoxlabel2.text = @"phone";
    [checkBoxlabel2 setTextAlignment: UITextAlignmentLeft];
    [checkBoxlabel2 setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    checkBoxlabel2.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:checkBoxlabel2];
    
    
    //checkbox button and label for phone option
    UIButton* checkBox2 = [[UIButton alloc] initWithFrame:CGRectMake(200, lastname.frame.origin.y + lastname.frame.size.height + 25, [UIScreen mainScreen].bounds.size.width - 20, 32)];
    [checkBox2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [checkBox2 addTarget:self action:@selector(checkBoxClicked:) forControlEvents: UIControlEventTouchUpInside];
    [checkBox2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [checkBox2 setImageEdgeInsets:UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0)];
    [scrollview addSubview:checkBox2];
    
    
    //email label and text field on gray view
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, label2.frame.origin.y + label2.frame.size.height + 0, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    label3.backgroundColor = [UIColor clearColor]; //2980B9
    label3.clipsToBounds = YES;
    label3.text = @"Email:*";
    [label3 setTextAlignment: UITextAlignmentLeft];
    [label3 setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    label3.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:label3];
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(70, checkBox.frame.origin.y + checkBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.font = [UIFont systemFontOfSize:15];
    email.placeholder = @"enter email";
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    email.keyboardType = UIKeyboardTypeDefault;
    email.returnKeyType = UIReturnKeyDone;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    email.delegate = self;
    [scrollview addSubview:email];
    
    
    //phone label and text field on gray view
    phone = [[UILabel alloc]initWithFrame:CGRectMake(10, email.frame.origin.y + email.frame.size.height + 15, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    phone.backgroundColor = [UIColor clearColor]; //2980B9
    phone.clipsToBounds = YES;
    phone.text = @"Phone:*";
    [phone setTextAlignment: UITextAlignmentLeft];
    [phone setFont:[UIFont fontWithName: BOLD_FONT size: 15.0f]];
    phone.textColor=[UIColor blackColor];
    [scrollview addSubview:phone];
    
    
    number = [[UITextField alloc] initWithFrame:CGRectMake(70, email.frame.origin.y + email.frame.size.height + 15, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    number.borderStyle = UITextBorderStyleRoundedRect;
    number.font = [UIFont systemFontOfSize:15];
    number.placeholder = @"enter phone number";
    number.autocorrectionType = UITextAutocorrectionTypeNo;
    number.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    number.returnKeyType = UIReturnKeyDone;
    number.clearButtonMode = UITextFieldViewModeWhileEditing;
    number.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    number.delegate = self;
    [scrollview addSubview:number];
    
    
    // white background textview
    UILabel * label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, number.frame.origin.y + number.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    label5.backgroundColor = [UIColor clearColor]; //2980B9
    label5.clipsToBounds = YES;
    label5.text = @"How can we help you?";
    [label5 setTextAlignment: UITextAlignmentLeft];
    [label5 setFont:[UIFont fontWithName: BOLD_FONT size: 18.0f]];
    label5.textColor=[UIColor colorFromHexCode:@"353535"];
    [scrollview addSubview:label5];
    
    //bottom text field
    UITextView *textbox = [[UITextView alloc] initWithFrame:CGRectMake(10, label5.frame.origin.y + label5.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    textbox.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    textbox.clipsToBounds = YES;
    textbox.layer.cornerRadius = 3;
    textbox.layer.shadowOffset = CGSizeMake(1, -2);
    textbox.layer.shadowRadius = 4;
    textbox.layer.shadowOpacity = 0.4;
    textbox.text = @"";
    textbox.font = [UIFont systemFontOfSize:12];
    textbox.autocorrectionType = UITextAutocorrectionTypeNo;
    textbox.keyboardType = UIKeyboardTypeDefault;
    textbox.returnKeyType = UIReturnKeyDone;
    textbox.delegate = self;
    [scrollview addSubview:textbox];
    
    //submit button
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.backgroundColor = [UIColor turquoiseColor]; 
    btn2.frame = CGRectMake(120, textbox.frame.origin.y + textbox.frame.size.height + 30, [UIScreen mainScreen].bounds.size.width - 250, 40);
    btn2.clipsToBounds = YES;
    btn2.layer.cornerRadius = 3;
    btn2.layer.shadowOffset = CGSizeMake(1, -2);
    btn2.layer.shadowRadius = 4;
    btn2.layer.shadowOpacity = 0.4;
    [btn2 setFont:[UIFont fontWithName: SEMI_BOLD_FONT  size: 15.0f]];
    btn2.tintColor = [UIColor colorFromHexCode:@"FFFFFF"];
    [btn2 setTitle:@"Submit" forState:UIControlStateNormal];

    [scrollview addSubview:btn2];
    
    
    //set our picker array data for set of options
    self.inquiry1 = [[NSArray alloc] initWithObjects:
                     @"Test Drive Request",
                     @"Get ePrice",
                     @"Request More Info",
                     @"Lease / Finance Info",
                     @"Service & Parts Info",
                     @"Service Appointment",
                     @"General Request",
                     @"Other",
                     nil];
    
}

//method to call when the "Done" button is clicked
- (void) selectedInquiry:(id)sender {
    
    //remove the "Done" button in the navigation bar
    self.navigationItem.rightBarButtonItem = nil;
    
    //which row number is selected for the inquiry1
    NSInteger inquiry1Row = [self.myCustomPicker selectedRowInComponent:1];
    
    //find the option1 based on the array index
    NSString *option1 = [self.inquiry1 objectAtIndex:inquiry1Row];
    
    //your selection for the inquiry
    NSString *myInquiry = [[NSString alloc] initWithFormat:
                           @"You selected %@ .",option1];
    
    //set the label text with your selection
    self.myLabel.text = myInquiry;
    
    //remove my custom picker view form the super view
    [self.myCustomPicker removeFromSuperview];
    
}

- (void) chooseTheInquiry:(UIButton *)paramSender{
    
    NSLog(@"Button was clicked, lets select our Inquiry");
    
    //if date picker doesn't exists then create it
    if(self.myCustomPicker == nil){
        self.myCustomPicker = [[UIPickerView alloc] init];
        self.myCustomPicker.backgroundColor = [UIColor whiteColor];
        
        //set the picker data source
        self.myCustomPicker.dataSource = self;
        //set the picker delegate
        self.myCustomPicker.delegate = self;
        //display the selection bar
        self.myCustomPicker.showsSelectionIndicator = YES;
    }
    
    //find the current view size
    CGRect screenRect = [self.view frame];
    NSLog(@"Screen frame %f %f", screenRect.origin.y, screenRect.size.height);
    
    //find the custom picker size
    CGSize pickerSize = [self.myCustomPicker sizeThatFits:CGSizeZero];
    
    //set the picker frame
    CGRect pickerRect = CGRectMake(0.0,
                                   screenRect.origin.y + screenRect.size.height - pickerSize.height,
                                   pickerSize.width,
                                   pickerSize.height);
    self.myCustomPicker.frame = pickerRect;
    
    //add the picker to the view
    [self.view addSubview:self.myCustomPicker];
    
    //create the navigation button if it doesn't exists
    if(self.doneButton == nil){
        self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(selectedInquiry::)];
    }
    //add the "Done" button to the right side of the navigation bar
    self.navigationItem.rightBarButtonItem = nil;
    
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    NSInteger result = 0;
    if ([pickerView isEqual:self.myCustomPicker]){
        result = 1;
    }
    return result;
}

// returns the number of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger result = 0;
    if ([pickerView isEqual:self.myCustomPicker]){
        switch (component) {
            case 0:
                result = [self.inquiry1 count];
                break;
                
            default:
                break;
        }
    }
    return result;
}

//return a plain NSString to display the row for the component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    NSString *result = nil;
    if ([pickerView isEqual:self.myCustomPicker]){
        switch (component) {
            case 0:
                result = [self.inquiry1 objectAtIndex:row];
                break;
                
            default:
                break;
        }
        
    }
    return result;
}

- (IBAction) buttonTaped:(UIButton *)sender
{
    myButton=(UIButton *) sender;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // Selection displays in myButton
    [myButton setTitle:[inquiry1 objectAtIndex:row] forState:UIControlStateNormal];
    myCustomPicker.hidden=YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)checkBoxClicked: (id) sender
{
    isChecked = !isChecked;
    UIButton* check = (UIButton*) sender;
    if (isChecked == NO)
        [check setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    else
        [check setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    
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
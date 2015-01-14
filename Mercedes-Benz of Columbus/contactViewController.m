//
//  contactViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 1/7/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "contactViewController.h"

@interface contactViewController ()

@end

@implementation contactViewController


- (void)viewDidAppear:(BOOL)animated {
    // main view background color
    self.view.backgroundColor = [UIColor blackColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 360, 600)];

    NSInteger viewcount= 4;
    for (int i = 0; i <viewcount; i++)
    {
        CGFloat y = i * self.view.frame.size.height;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y,                                                      self.view.frame.size.width, self .view.frame.size.height)];
        view.backgroundColor = [UIColor greenColor];
        [self.view addSubview:scrollview];
    }
        scrollview.contentSize = CGSizeMake(350, 200 *viewcount);
    
    //checkbox == 0;
    
    self.navigationItem.hidesBackButton = YES;

    
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName: @"AvenirNext-DemiBold" size: 14.0f]} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButton;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
   //top image with logo
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
    [bgImage setImage:[UIImage imageNamed:@"montage.png"]];
    [bgImage setContentMode:UIViewContentModeScaleAspectFill];
    [bgImage setClipsToBounds:YES];
    [self.view addSubview:bgImage];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, -22, 200, 150)];
    [logo setImage:[UIImage imageNamed:@"logo-tagline-white.png"]];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:logo];
    
    //select inquiry button
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f]; //2980B9
    btn1.frame = CGRectMake(12, 140, 200, 50);
    btn1.clipsToBounds = YES;
    btn1.layer.cornerRadius = 3;
    btn1.layer.shadowOffset = CGSizeMake(1, -2);
    btn1.layer.shadowRadius = 4;
    btn1.layer.shadowOpacity = 0.4;
    [btn1 setTitle:@"Select your inquiry..." forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollview addSubview:btn1];
    
    // gray background centerview
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(15, 215, 360, 450)];
    [centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    centerView.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f];
    [scrollview addSubview:centerView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label.backgroundColor = [UIColor clearColor]; //2980B9
    label.frame = CGRectMake(5, 0, 300, 20);
    label.clipsToBounds = YES;
    label.text = @"Fields marked with an asterick(*) must be provided";
    [label setTextAlignment: UITextAlignmentLeft];
    [label setFont:[UIFont boldSystemFontOfSize:10]];
    label.textColor=[UIColor blackColor];
    [centerView addSubview:label];
    
    //name label and textfields on gray view
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label1.backgroundColor = [UIColor clearColor]; //2980B9
    label1.frame = CGRectMake(10, 40, 100, 50);
    label1.clipsToBounds = YES;
    label1.text = @"Name:*";
    [label1 setTextAlignment: UITextAlignmentLeft];
    [label1 setFont:[UIFont boldSystemFontOfSize:14]];
    label1.textColor=[UIColor blackColor];
    [centerView addSubview:label1];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(70, 50, 120, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"first name";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [centerView addSubview:textField];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(200, 50, 130, 30)];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.font = [UIFont systemFontOfSize:15];
    textField1.placeholder = @"last name";
    textField1.autocorrectionType = UITextAutocorrectionTypeNo;
    textField1.keyboardType = UIKeyboardTypeDefault;
    textField1.returnKeyType = UIReturnKeyDone;
    textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField1.delegate = self;
    [centerView addSubview:textField1];
    
    //contact label and check buttons on gray view
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label2.backgroundColor = [UIColor clearColor]; //2980B9
    label2.frame = CGRectMake(10, 90, 200, 50);
    label2.clipsToBounds = YES;
    label2.text = @"Contact me by:";
    [label2 setTextAlignment: UITextAlignmentLeft];
    [label2 setFont:[UIFont boldSystemFontOfSize:14]];
    label2.textColor=[UIColor blackColor];
    [centerView addSubview:label2];

    
        UIButton * cbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage * buttonImage = [UIImage imageNamed:@"checkbox.png"];
        cbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cbtn.frame = CGRectMake(10, 100, 277, 32);
        [cbtn setImage:buttonImage forState:UIControlStateNormal];
        [cbtn setTitle:@"email" forState:UIControlStateNormal];
        [cbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [centerView addSubview:cbtn];
   
    
    UIButton * cbtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage * buttonImage2 = [UIImage imageNamed:@"checkbox-checked.png"];
    cbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    cbtn2.frame = CGRectMake(100, 100, 277, 32);
    [cbtn2 setImage:buttonImage2 forState:UIControlStateNormal];
    [cbtn2 setTitle:@"phone" forState:UIControlStateNormal];
    [cbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [centerView addSubview:cbtn2];
    
    
//    UIButton * checkboxBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImage * btnImage = [UIImage imageNamed:@"checkbox-checked.png"];
//    checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    checkboxBtn.frame = CGRectMake(22, 95, 277, 32);
//    [checkboxBtn setImage:btnImage forState:UIControlStateNormal];
//    [centerView addSubview:checkboxBtn];
    
    //email label and text field on gray view
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label3.backgroundColor = [UIColor clearColor]; //2980B9
    label3.frame = CGRectMake(10, 140, 100, 50);
    label3.clipsToBounds = YES;
    label3.text = @"Email:*";
    [label3 setTextAlignment: UITextAlignmentLeft];
    [label3 setFont:[UIFont boldSystemFontOfSize:14]];
    label3.textColor=[UIColor blackColor];
    [centerView addSubview:label3];
    
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(70, 150, 260, 30)];
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.font = [UIFont systemFontOfSize:15];
    textField3.placeholder = @"enter email";
    textField3.autocorrectionType = UITextAutocorrectionTypeNo;
    textField3.keyboardType = UIKeyboardTypeDefault;
    textField3.returnKeyType = UIReturnKeyDone;
    textField3.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField3.delegate = self;
    [centerView addSubview:textField3];
    
    //phone label and text field on gray view
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label4.backgroundColor = [UIColor clearColor]; //2980B9
    label4.frame = CGRectMake(10, 190, 100, 50);
    label4.clipsToBounds = YES;
    label4.text = @"Phone:*";
    [label4 setTextAlignment: UITextAlignmentLeft];
    [label4 setFont:[UIFont boldSystemFontOfSize:14]];
    label4.textColor=[UIColor blackColor];
    [centerView addSubview:label4];
    
    UITextField *textField4 = [[UITextField alloc] initWithFrame:CGRectMake(70, 200, 80, 30)];
    textField4.borderStyle = UITextBorderStyleRoundedRect;
    textField4.font = [UIFont systemFontOfSize:15];
   // textField4.placeholder = @"enter phone number";
    textField4.autocorrectionType = UITextAutocorrectionTypeNo;
    textField4.keyboardType = UIKeyboardTypeNumberPad;
    textField4.returnKeyType = UIReturnKeyDone;
    textField4.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField4.delegate = self;
    [centerView addSubview:textField4];
    
    UITextField *textField5 = [[UITextField alloc] initWithFrame:CGRectMake(160, 200, 80, 30)];
    textField5.borderStyle = UITextBorderStyleRoundedRect;
    textField5.font = [UIFont systemFontOfSize:15];
    // textField4.placeholder = @"enter phone number";
    textField5.autocorrectionType = UITextAutocorrectionTypeNo;
    textField5.keyboardType = UIKeyboardTypeNumberPad;
    textField5.returnKeyType = UIReturnKeyDone;
    textField5.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField5.delegate = self;
    [centerView addSubview:textField5];
    
    UITextField *textField6 = [[UITextField alloc] initWithFrame:CGRectMake(250, 200, 80, 30)];
    textField6.borderStyle = UITextBorderStyleRoundedRect;
    textField6.font = [UIFont systemFontOfSize:15];
    // textField4.placeholder = @"enter phone number";
    textField6.autocorrectionType = UITextAutocorrectionTypeNo;
    textField6.keyboardType = UIKeyboardTypeNumberPad;
    textField6.returnKeyType = UIReturnKeyDone;
    textField6.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField6.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField6.delegate = self;
    [centerView addSubview:textField6];
    
    // white background textview
    UILabel * label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label5.backgroundColor = [UIColor clearColor]; //2980B9
    label5.frame = CGRectMake(10, 235, 300, 50);
    label5.clipsToBounds = YES;
    label5.text = @"How can we help you?";
    [label5 setTextAlignment: UITextAlignmentLeft];
    [label5 setFont:[UIFont boldSystemFontOfSize:18]];
    label5.textColor=[UIColor blackColor];
    [centerView addSubview:label5];
    
    //bottom text field
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(10, 275, 320, 100)];
    text.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    text.text = @"";
   // textField7.borderStyle = UITextBorderStyleRoundedRect;
    text.font = [UIFont systemFontOfSize:12];
    // textField4.placeholder = @"enter phone number";
    text.autocorrectionType = UITextAutocorrectionTypeNo;
    text.keyboardType = UIKeyboardTypeDefault;
    text.returnKeyType = UIReturnKeyDone;
    text.delegate = self;
    [centerView addSubview:text];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.backgroundColor = [UIColor colorWithRed:0/255.0f green:202/255.0f blue:0/255.0f alpha:1.0f]; //2980B9
    btn2.frame = CGRectMake(120, 390, 100, 40);
    btn2.clipsToBounds = YES;
    btn2.layer.cornerRadius = 3;
    btn2.layer.shadowOffset = CGSizeMake(1, -2);
    btn2.layer.shadowRadius = 4;
    btn2.layer.shadowOpacity = 0.4;
    [btn2 setTitle:@"Submit" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [centerView addSubview:btn2];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldReturn:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}


- (IBAction)checkbox:(id)sender{
    
    if (!checkbox) {
        [checkboxButton setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        checkbox = YES;
    }
    
    else if (checkbox) {
        [checkboxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        checkbox = NO;
    }

//    if (checkboxSelected == 0){
//        [checkboxButton setSelected:YES];
//        checkboxSelected = 1;
//    } else {
//        [checkboxButton setSelected:NO];
//        checkboxSelected = 0;
//    }
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

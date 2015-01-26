//
//  AppointmentViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
 
    BOOL isChecked;
    UIButton *checkboxButton;
}

@property BOOL isChecked;;
@property (nonatomic, retain) UIButton *checkboxButton;
@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic, strong) NSArray *inquiry1, *inquiry2;
@property (nonatomic, strong) UIPickerView *myCustomPicker;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) UILabel *myLabel, *phone;
@property (nonatomic, strong) UITextField *firstname, *lastname, *email, *number;

-(void)checkBoxClicked:(id)sender;

@end


//
//  AppointmentViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
    BOOL checkbox;
    IBOutlet UIButton *checkboxButton;
}

- (IBAction)checkbox:(id)sender;

@end

//
//  contactViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 1/7/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
BOOL checkbox;
IBOutlet UIButton *checkboxButton;

}

- (IBAction)checkbox:(id)sender;

@end

//
//  Common.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/23/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

typedef enum {
    Default,
    Home
} headerType;

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Common : NSObject {
    headerType headerType;
}

extern NSString* const LIGHT_FONT;
extern NSString* const REGULAR_FONT;
extern NSString* const SEMI_BOLD_FONT;
extern NSString* const BOLD_FONT;

+ (UITableViewCell *)headerOfType:(headerType)type withTitle:(NSString*)title withIcon:(UIImage*)iconImage;
+ (UIView *)headerWithTitle:(NSString*)title withIcon:(UIImage*)iconImage;
+ (UIBarButtonItem *)backButton;
+ (UIBarButtonItem *)optionsButtonWithTarget:(id)target andAction:(SEL)action;
+ (NSString *)formatPhoneNumber:(NSString*)number;
+ (NSString *)formatTimeRangeWithStart:(NSString *)start andEnd:(NSString *)end;
+ (void)showErrorMessageWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle;

@end

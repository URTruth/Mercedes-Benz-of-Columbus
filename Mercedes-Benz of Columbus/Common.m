//
//  Common.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/23/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "Common.h"

@implementation Common

NSString* const LIGHT_FONT = @"AppleSDGothicNeo-Light";
NSString* const REGULAR_FONT = @"AppleSDGothicNeo-Regular";
NSString* const SEMI_BOLD_FONT = @"AppleSDGothicNeo-SemiBold";
NSString* const BOLD_FONT = @"AppleSDGothicNeo-Bold";

- (UITableViewCell *)headerOfType:(headerType)type withTitle:(NSString*)title withIcon:(UIImage*)iconImage {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell addSubview:[self headerMontageImageView]];
    if((int)type == Home) {
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, -22, 200, 150)];
        [logo setImage:[UIImage imageNamed:@"logo-tagline-white.png"]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [cell addSubview:logo];
    } else {
        [cell addSubview:[self headerIconImageViewWithImage:iconImage]];
        [cell addSubview:[self headerTitleLabelWithText:title]];
    }
    return cell;
}

- (UIView *)headerWithTitle:(NSString*)title withIcon:(UIImage*)iconImage {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
    [view addSubview:[self headerMontageImageView]];
    [view addSubview:[self headerIconImageViewWithImage:iconImage]];
    [view addSubview:[self headerTitleLabelWithText:title]];
    return view;
}

- (UIBarButtonItem *)backButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f]} forState:UIControlStateNormal];
    return backButton;
}

- (UIBarButtonItem *)optionsButtonWithTarget:(id)target andAction:(SEL)action {
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *navBtnImage = [UIImage imageNamed:@"nav.png"];
    [navBtn setBackgroundImage:navBtnImage forState:UIControlStateNormal];
    [navBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    navBtn.frame = CGRectMake(0, 0, 21, 21);
    return [[UIBarButtonItem alloc] initWithCustomView:navBtn];
}

- (NSString *)formatPhoneNumber:(NSString*)number {
    NSArray *components = [number componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 0 && [decimalString characterAtIndex:0] == '1';
    
    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
        return number;
    }
    
    NSUInteger index = 0;
    NSMutableString *formattedString = [NSMutableString string];
    
    if (hasLeadingOne) {
        [formattedString appendString:@"1 "];
        index += 1;
    }
    
    if (length - index > 3) {
        NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"(%@) ",areaCode];
        index += 3;
    }
    
    if (length - index > 3) {
        NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"%@-",prefix];
        index += 3;
    }
    
    NSString *remainder = [decimalString substringFromIndex:index];
    [formattedString appendString:remainder];
    
    return formattedString;
}

- (NSString *)formatTimeRangeWithStart:(NSString *)start andEnd:(NSString *)end {
    if([start isEqualToString:@"n/a"] || [end isEqualToString:@"n/a"]) {
        return @"Closed All Day";
    }
    return [NSString stringWithFormat:@"%@ - %@", start, end];
}

// Private methods

- (UIImageView *)headerMontageImageView {
    UIImageView *montageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
    [montageImageView setImage:[UIImage imageNamed:@"montage.png"]];
    [montageImageView setContentMode:UIViewContentModeScaleAspectFill];
    [montageImageView setClipsToBounds:YES];
    return montageImageView;
}

- (UIImageView *)headerIconImageViewWithImage:(UIImage *)image {
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 28, 32, 32)];
    [iconImageView setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    iconImageView.tintColor = [UIColor whiteColor];
    [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    return iconImageView;
}

- (UILabel *)headerTitleLabelWithText:(NSString *)text {
    int titleLabelFont = 23;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 34, 200, titleLabelFont)];
    [titleLabel setFont:[UIFont fontWithName:LIGHT_FONT size:titleLabelFont]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:text];
    return titleLabel;
}

@end

//
//  Common.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/23/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"

@implementation Common

NSString* const LIGHT_FONT = @"AppleSDGothicNeo-Light";
NSString* const REGULAR_FONT = @"AppleSDGothicNeo-Regular";
NSString* const SEMI_BOLD_FONT = @"AppleSDGothicNeo-SemiBold";
NSString* const BOLD_FONT = @"AppleSDGothicNeo-Bold";

+ (UITableViewCell *)headerOfType:(headerType)type withTitle:(NSString*)title withIcon:(UIImage*)iconImage withBackground:(UIImage*)backgroundImage {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell addSubview:[self headerMontageImageViewWithImage:backgroundImage]];
    if((int)type == Home) {
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(5, -35, 225, 175)];
        [logo setImage:[UIImage imageNamed:@"logo.png"]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [cell addSubview:logo];
    } else {
        [cell addSubview:[self headerIconImageViewWithImage:iconImage]];
        [cell addSubview:[self headerTitleLabelWithText:title]];
    }
    return cell;
}

+ (UIView *)headerWithTitle:(NSString*)title withIcon:(UIImage*)iconImage withBackground:(UIImage*)backgroundImage  {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
    [view addSubview:[self headerMontageImageViewWithImage:backgroundImage]];
    [view addSubview:[self headerIconImageViewWithImage:iconImage]];
    [view addSubview:[self headerTitleLabelWithText:title]];
    return view;
}

+ (UIBarButtonItem *)backButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor], NSFontAttributeName:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f]} forState:UIControlStateNormal];
    return backButton;
}

+ (UIBarButtonItem *)optionsButtonWithTarget:(id)target andAction:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button setImage:[UIImage imageNamed:@"phone2.png"] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageView.frame = CGRectMake(0, 0, 21, 21);
    UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [optionsButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor], NSFontAttributeName:[UIFont fontWithName: SEMI_BOLD_FONT size: 14.0f]} forState:UIControlStateNormal];
    return optionsButton;
}

+ (NSString *)formatPhoneNumber:(NSString*)number {
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

+ (NSString *)formatTimeRangeWithStart:(NSString *)start andEnd:(NSString *)end {
    if([start isEqualToString:@"n/a"] || [end isEqualToString:@"n/a"]) {
        return @"Closed All Day";
    }
    return [NSString stringWithFormat:@"%@ - %@", start, end];
}

+ (void)showErrorMessageWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil];
    [alertView show];
}

+ (UITextField *)textBoxWithPlaceholder:(NSString*)placeholder frame:(CGRect)frame target:(id)target {
    UITextField* textBox = [[UITextField alloc] initWithFrame:frame];
    textBox.borderStyle = UITextBorderStyleRoundedRect;
    textBox.font = [UIFont fontWithName:@"AvenirNext-Regular" size:15.0];
    textBox.layer.cornerRadius=8.0f;
    textBox.layer.masksToBounds=YES;
    [textBox setBackgroundColor:[UIColor CustomGrayColor]];
    textBox.layer.borderWidth= 0.0f;
    textBox.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    textBox.autocorrectionType = UITextAutocorrectionTypeNo;
    textBox.keyboardType = UIKeyboardTypeDefault;
    textBox.textColor = [UIColor whiteColor];
    textBox.returnKeyType = UIReturnKeyDone;
    textBox.clearButtonMode = UITextFieldViewModeWhileEditing;
    textBox.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textBox.delegate = target;
    return textBox;
}

+ (FUIButton *)buttonWithText:(NSString*)text color:(UIColor*)color frame:(CGRect)frame {
    FUIButton *button = [[FUIButton alloc] initWithFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    button.buttonColor = color;
    button.cornerRadius = 3.0f;
    button.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:16.0];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    return button;
}

+ (NSString *)webServiceUrlWithPath:(NSString *)path {
    return [@"http://www.wavelinkllc.com/mboc/" stringByAppendingString:path];
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = [[UIScreen mainScreen] bounds].size.width; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+ (UIColor *)navigationBarTintColor {
    return [UIColor colorFromHexCode:@"#dfdfdf"];
}

// Private methods

+ (UIImageView *)headerMontageImageViewWithImage:(UIImage *)image {
    UIImageView *montageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
    [montageImageView setImage:image];
    [montageImageView setContentMode:UIViewContentModeScaleAspectFill];
    [montageImageView setClipsToBounds:YES];
    return montageImageView;
}

+ (UIImageView *)headerIconImageViewWithImage:(UIImage *)image {
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 28, 32, 32)];
    [iconImageView setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    iconImageView.tintColor = [UIColor whiteColor];
    [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    return iconImageView;
}

+ (UILabel *)headerTitleLabelWithText:(NSString *)text {
    int titleLabelFont = 23;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 34, 200, titleLabelFont)];
    [titleLabel setFont:[UIFont fontWithName:LIGHT_FONT size:titleLabelFont]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:text];
    return titleLabel;
}

@end

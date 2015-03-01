//
//  User.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *_userId;
    NSString *_email;
    NSString *_password;
    NSString *_name;
    NSString *_vin;
    NSString *_photo;
    NSString *_phone;
    NSString *_facebookId;
    NSString *_facebookEmail;
    NSString *_facebookFirstName;
    NSString *_facebookLastName;
    NSString *_facebookPictureURL;
    NSString *_twitterId;
    NSString *_deviceToken;
}

+ (User *)sharedInstance;

@property(strong, nonatomic, readwrite) NSString *userId;
@property(strong, nonatomic, readwrite) NSString *email;
@property(strong, nonatomic, readwrite) NSString *password;
@property(strong, nonatomic, readwrite) NSString *name;
@property(strong, nonatomic, readwrite) NSString *vin;
@property(strong, nonatomic, readwrite) NSString *photo;
@property(strong, nonatomic, readwrite) NSString *phone;
@property(strong, nonatomic, readwrite) NSString *facebookId;
@property(strong, nonatomic, readwrite) NSString *facebookEmail;
@property(strong, nonatomic, readwrite) NSString *facebookFirstName;
@property(strong, nonatomic, readwrite) NSString *facebookLastName;
@property(strong, nonatomic, readwrite) NSString *facebookPictureURL;
@property(strong, nonatomic, readwrite) NSString *twitterId;
@property(strong, nonatomic, readwrite) NSString *deviceToken;

@end

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
    NSString *_firstName;
    NSString *_lastName;
    NSString *_vin;
    NSString *_photo;
    NSString *_bio;
    NSString *_gender;
    NSString *_phone;
    NSString *_facebookId;
    NSString *_twitterToken;
    NSString *_twitterSecret;
}

+ (User *)sharedInstance;

@property(strong, nonatomic, readwrite) NSString *userId;
@property(strong, nonatomic, readwrite) NSString *email;
@property(strong, nonatomic, readwrite) NSString *password;
@property(strong, nonatomic, readwrite) NSString *firstName;
@property(strong, nonatomic, readwrite) NSString *lastName;
@property(strong, nonatomic, readwrite) NSString *vin;
@property(strong, nonatomic, readwrite) NSString *photo;
@property(strong, nonatomic, readwrite) NSString *bio;
@property(strong, nonatomic, readwrite) NSString *gender;
@property(strong, nonatomic, readwrite) NSString *phone;
@property(strong, nonatomic, readwrite) NSString *facebookId;
@property(strong, nonatomic, readwrite) NSString *twitterToken;
@property(strong, nonatomic, readwrite) NSString *twitterSecret;

@end

//
//  User.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userId = _userId;
@synthesize email = _email;
@synthesize password = _password;
@synthesize name = _name;
@synthesize vin = _vin;
@synthesize photo = _photo;
@synthesize phone = _phone;
@synthesize facebookId = _facebookId;
@synthesize facebookEmail = _facebookEmail;
@synthesize facebookFirstName = _facebookFirstName;
@synthesize facebookLastName = _facebookLastName;
@synthesize facebookPictureURL = _facebookPictureURL;
@synthesize twitterId = _twitterId;
@synthesize deviceToken = _deviceToken;

+ (User *)sharedInstance {
    static dispatch_once_t onceToken;
    static User *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[User alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _userId = nil;
        _email = nil;
        _password = nil;
        _vin = nil;
        _photo = nil;
        _phone = nil;
        _facebookId = nil;
        _facebookEmail = nil;
        _facebookFirstName = nil;
        _facebookLastName = nil;
        _facebookPictureURL = nil;
        _twitterId = nil;
        _deviceToken = nil;
    }
    return self;
}

@end

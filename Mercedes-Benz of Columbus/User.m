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
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize vin = _vin;
@synthesize photo = _photo;
@synthesize bio = _bio;
@synthesize gender = _gender;
@synthesize phone = _phone;
@synthesize facebookId = _facebookId;
@synthesize twitterToken = _twitterToken;
@synthesize twitterSecret = _twitterSecret;

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
        _firstName = nil;
        _lastName = nil;
        _vin = nil;
        _photo = nil;
        _bio = nil;
        _gender = nil;
        _phone = nil;
        _facebookId = nil;
        _twitterToken = nil;
        _twitterSecret = nil;
    }
    return self;
}

@end

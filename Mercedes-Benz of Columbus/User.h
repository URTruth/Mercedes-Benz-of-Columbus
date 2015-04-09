//
//  User.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginCompletionBlock)(BOOL isSuccess);
typedef void(^LogoutCompletionBlock)(BOOL isSuccess);

@interface User : NSObject {
    NSString *_userId;
    NSString *_email;
    NSString *_name;
    NSString *_vin;
    NSString *_photo;
    NSString *_phone;
    NSString *_facebookId;
    NSString *_twitterId;
    NSString *_digitsId;
    NSString *_deviceToken;
    BOOL _isLoggedIn;
}

+ (User *)sharedInstance;

- (void)login:(LoginCompletionBlock) loginBlock;
- (void)logout:(LogoutCompletionBlock) logoutBlock;

@property(strong, nonatomic, readwrite) NSString *userId;
@property(strong, nonatomic, readwrite) NSString *email;
@property(strong, nonatomic, readwrite) NSString *name;
@property(strong, nonatomic, readwrite) NSString *vin;
@property(strong, nonatomic, readwrite) NSString *photo;
@property(strong, nonatomic, readwrite) NSString *phone;
@property(strong, nonatomic, readwrite) NSString *facebookId;
@property(strong, nonatomic, readwrite) NSString *twitterId;
@property(strong, nonatomic, readwrite) NSString *digitsId;
@property(strong, nonatomic, readwrite) NSString *deviceToken;
@property(nonatomic, assign, readwrite) BOOL isLoggedIn;

@end

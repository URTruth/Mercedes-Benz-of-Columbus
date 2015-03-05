//
//  User.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "User.h"
#import "Common.h"

#import "ACSimpleKeychain.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"

@implementation User

@synthesize userId = _userId;
@synthesize email = _email;
@synthesize name = _name;
@synthesize vin = _vin;
@synthesize photo = _photo;
@synthesize phone = _phone;
@synthesize facebookId = _facebookId;
@synthesize twitterId = _twitterId;
@synthesize digitsId = _digitsId;
@synthesize deviceToken = _deviceToken;
@synthesize isLoggedIn = _isLoggedIn;

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
        _name = nil;
        _vin = nil;
        _photo = nil;
        _phone = nil;
        _facebookId = nil;
        _twitterId = nil;
        _digitsId = nil;
        _deviceToken = nil;
        _isLoggedIn = nil;
    }
    return self;
}

- (void)login:(LoginCompletionBlock) loginBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"userId":ObjectOrNull([User sharedInstance].userId), @"facebookId":ObjectOrNull([User sharedInstance].facebookId),  @"twitterId":ObjectOrNull([User sharedInstance].twitterId), @"digitsId":ObjectOrNull([User sharedInstance].digitsId), @"iOSdeviceToken":ObjectOrNull([User sharedInstance].deviceToken) };
    [manager POST:[Common webServiceUrlWithPath:@"login.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseData = (NSDictionary*)responseObject;
        if ([[responseData objectForKey:@"authenticated"] isEqualToString:@"true"]){
            [User sharedInstance].userId = [responseData objectForKey:@"userId"];
            [User sharedInstance].name= [responseData objectForKey:@"name"];
            [User sharedInstance].email = [responseData objectForKey:@"email"];
            [User sharedInstance].phone = [responseData objectForKey:@"phone"];
            [User sharedInstance].photo = [responseData objectForKey:@"photo"];
            [User sharedInstance].vin = [responseData objectForKey:@"vin"];
            [User sharedInstance].facebookId = [responseData objectForKey:@"facebookId"];
            [User sharedInstance].twitterId = [responseData objectForKey:@"twitterId"];
            [User sharedInstance].digitsId = [responseData objectForKey:@"digitsId"];
            [User sharedInstance].isLoggedIn = true;
            ACSimpleKeychain *keychain = [ACSimpleKeychain defaultKeychain];
            if ([keychain storeUsername:[User sharedInstance].userId password:nil identifier:@"account" forService:@"Mercedes-Benz of Columbus"]) {
                NSLog(@"SAVED credentials for 'Mercedes-Benz of Columbus' credentials identifier 'account'");
            }
            loginBlock(true);
        }else{
            loginBlock(false);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
        loginBlock(false);
    }];
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

@end

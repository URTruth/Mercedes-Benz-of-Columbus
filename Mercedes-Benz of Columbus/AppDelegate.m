//
//  AppDelegate.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 11/28/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "ACSimpleKeychain.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "Appirater.h"
#import "GAI.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    // [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [FBSession class];
    [FBLoginView class];
    [Fabric with:@[TwitterKit]];
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelError];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-78798810-1"];
    
    [Appirater setAppId:@"947780293"];
    [Appirater setDaysUntilPrompt:0];
    [Appirater setUsesUntilPrompt:3];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:3];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
     
    ACSimpleKeychain *keychain = [ACSimpleKeychain defaultKeychain];
    NSDictionary *credentials = [keychain credentialsForIdentifier:@"account" service:@"Mercedes-Benz of Columbus"];
    [User sharedInstance].userId = [credentials valueForKey:ACKeychainUsername];
    
    UIAlertView *discontinueAlert = [[UIAlertView alloc] initWithTitle:@"ATTENTION"
                                                    message:@"The Mercedes-Benz of Columbus app will be discontinued on July 31st, 2018. Thank you for downloaded and using the app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [discontinueAlert show];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWarned = [userDefaults boolForKey:@"isWarned"];
    if (!isWarned) {
        UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"Disclaimer"
                                                        message:@"This app is for current and potential customers of the Mercedes-Benz of COLUMBUS, GEORGIA dealership. If you need services for a different dealership, please find their specific website or app on the App Store."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [locationAlert show];
        [userDefaults setObject:@YES forKey:@"isWarned"];
        [userDefaults synchronize];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [NSHTTPCookieStorage sharedHTTPCookieStorage].cookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
    [FBAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
     return [[FBSession activeSession] handleOpenURL:url];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification
{
    if ( application.applicationState == UIApplicationStateActive ) { // app was already in the foreground
        //[self handleInAppPushNotification:notification];
    } else {
        //[self handlePushNotificationClick:notification];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // You can send here, for example, an asynchronous HTTP request to your web-server to store this deviceToken remotely.
    NSLog(@"Did register for remote notifications: %@", deviceToken);
    [User sharedInstance].deviceToken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"iOSdeviceToken":[User sharedInstance].deviceToken ?: [NSNull null] };
    [manager POST:[Common webServiceUrlWithPath:@"save_device.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Did save device token: %@", [User sharedInstance].deviceToken);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fail to save device token: %@", error);
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Fail to register for remote notifications: %@", error);
}

@end

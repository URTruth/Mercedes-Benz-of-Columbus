//
//  SettingsViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/6/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property(nonatomic, strong) UIImageView *backgroundImage;
@property(nonatomic, strong) UIImageView *arrowImage;

@property (nonatomic, strong) UIButton *notifications;
@property (nonatomic, strong) UIButton *share;
@property (nonatomic, strong) UIButton *muteSound;
@property (nonatomic, strong) UIButton *specialOffer;
@property (nonatomic, strong) UIButton *serviceOffers;
@property (nonatomic, strong) UIButton *news;

@property (nonatomic, strong) UISwitch *soundSwitch;
@property (nonatomic, strong) UISwitch *specialSwitch;
@property (nonatomic, strong) UISwitch *serviceSwitch;
@property (nonatomic, strong) UISwitch *newsSwitch;


@end

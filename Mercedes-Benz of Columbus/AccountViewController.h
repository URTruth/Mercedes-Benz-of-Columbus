//
//  AccountViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController

@property(nonatomic, strong) UIImageView *backgroundImage;

@property(nonatomic, strong) UIImageView *carImage;
@property(nonatomic, strong) UIImageView *shareImage;
@property(nonatomic, strong) UIImageView *arrowImage;

@property (nonatomic, strong) UIButton *logOut, *myCar, *share;

@end

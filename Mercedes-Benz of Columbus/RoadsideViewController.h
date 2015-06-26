//
//  RoadsideViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 3/9/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FUIButton.h"

@interface RoadsideViewController : UIViewController <UIScrollViewDelegate>

@property(nonatomic, strong) NSMutableDictionary *settingData;

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) FUIButton *numberButton;

@end

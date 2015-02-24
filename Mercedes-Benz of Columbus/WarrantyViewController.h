//
//  WarrantyViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/23/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarrantyViewController : UIViewController

@property(nonatomic, strong) UIImageView *backgroundImage;

@property (strong, nonatomic) IBOutlet UITextField *VIN;
@property (nonatomic, strong) UIButton *submit;

@end

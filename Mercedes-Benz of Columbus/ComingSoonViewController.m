//
//  ComingSoonViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/27/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "ComingSoonViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"

@interface ComingSoonViewController ()

@end

@implementation ComingSoonViewController
@synthesize backgroundImage;
@synthesize comingSoonLabel;
@synthesize iconImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"montage.png"]];
    [self.view addSubview:backgroundImage];
    
    int iconImageViewSize = 32;
    iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundImage.frame.size.width - iconImageViewSize)/2, 150, iconImageViewSize, iconImageViewSize)];
    [iconImageView setImage:[[UIImage imageNamed:@"service.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    iconImageView.tintColor = [UIColor whiteColor];
    [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    [backgroundImage addSubview:iconImageView];
    
    int comingSoonLabelWidth = 320;
    int comingSoonLabelFontSize = 20;
    comingSoonLabel = [[UILabel alloc] initWithFrame:CGRectMake((backgroundImage.frame.size.width - comingSoonLabelWidth)/2, iconImageView.frame.origin.y + iconImageView.frame.size.height + 20, comingSoonLabelWidth, comingSoonLabelFontSize)];
    [comingSoonLabel setFont:[UIFont fontWithName:BOLD_FONT size:comingSoonLabelFontSize]];
    [comingSoonLabel setTextColor:[UIColor whiteColor]];
    [comingSoonLabel setTextAlignment:NSTextAlignmentCenter];
    [comingSoonLabel setText:@"This page is coming soon!"];
    [backgroundImage addSubview:comingSoonLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

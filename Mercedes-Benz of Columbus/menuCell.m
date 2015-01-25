//
//  menuCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/22/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "menuCell.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"

@implementation menuCell
@synthesize iconImageView;
@synthesize nameLabel;
@synthesize badgeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[self layer] setShouldRasterize:YES];
        [[self layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 11.5, 27, 27)];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [iconImageView setBackgroundColor:[UIColor clearColor]];
        iconImageView.alpha = .5;
        [self addSubview:iconImageView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 18, 200, 18)];
        [nameLabel setTextColor: [UIColor darkGrayColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont fontWithName: LIGHT_FONT size: 18.0f]];
        [self addSubview:nameLabel];
        
        badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 0, 22)]; // 'x' coordinate and width are both resized in controller
        [badgeLabel setTextAlignment:UITextAlignmentCenter];
        [badgeLabel setTextColor: [UIColor whiteColor]];
        [badgeLabel setBackgroundColor:[UIColor CustomGrayColor]];
        [badgeLabel setFont:[UIFont fontWithName: BOLD_FONT size: 12.0f]];
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2;
        [badgeLabel.layer setMasksToBounds:YES];
        [badgeLabel setAlpha:0];
        [self addSubview:badgeLabel];
        
        self.backgroundColor = [UIColor colorFromHexCode:@"dfdfdf"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

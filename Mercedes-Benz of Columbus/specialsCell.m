//
//  specialsCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/23/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "specialsCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"

#import "UIColor+FlatUI.h"

@implementation specialsCell
@synthesize backgroundImageView;
@synthesize titleLabel;
@synthesize descriptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[self layer] setShouldRasterize:YES];
        [[self layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        
        int padding = 10;
        
        backgroundImageView = [[UIImageView alloc] init];
        [backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [backgroundImageView setClipsToBounds:YES];
        [self addSubview:backgroundImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 300, 16)];
        [titleLabel setFont:[UIFont fontWithName:SEMI_BOLD_FONT size:16]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        titleLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        titleLabel.layer.shadowRadius = 1.0;
        titleLabel.layer.shadowOpacity = 1.0;
        [self addSubview:titleLabel];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding + titleLabel.frame.size.height, 300, 10)];
        [descriptionLabel setFont:[UIFont fontWithName:REGULAR_FONT size:10]];
        [descriptionLabel setTextColor:[UIColor whiteColor]];
        descriptionLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        descriptionLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        descriptionLabel.layer.shadowRadius = 1.0;
        descriptionLabel.layer.shadowOpacity = 1.0;
        [self addSubview:descriptionLabel];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

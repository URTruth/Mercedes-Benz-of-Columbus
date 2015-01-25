//
//  specialsCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/23/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "specialsCell.h"
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
        
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        [backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [backgroundImageView setClipsToBounds:YES];
        [self addSubview:backgroundImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 300, 16)];
        [titleLabel setFont:[UIFont fontWithName:SEMI_BOLD_FONT size:16]];
        [titleLabel setTextColor:[UIColor asbestosColor]];
        [self addSubview:titleLabel];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding + titleLabel.frame.size.height, 300, 10)];
        [descriptionLabel setFont:[UIFont fontWithName:REGULAR_FONT size:10]];
        [descriptionLabel setTextColor:[UIColor asbestosColor]];
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

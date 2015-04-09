//
//  vehicleDetailCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 4/8/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "vehicleDetailCell.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"

@implementation vehicleDetailCell
@synthesize photoImageView;
@synthesize nameLabel;
@synthesize auxLabel;
@synthesize arrowLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[self layer] setShouldRasterize:YES];
        [[self layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        
        int padding = 10;
        int imageSize = 38;
        
        photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding*2, padding, imageSize, imageSize)];
        [photoImageView setContentMode:UIViewContentModeScaleAspectFill];
        [photoImageView setClipsToBounds:YES];
        photoImageView.alpha = .5;
        [self addSubview:photoImageView];
        
        int labelWidth = [UIScreen mainScreen].bounds.size.width - padding - photoImageView.frame.size.width;
        int labelX = 80;
        
        int nameLabelFont = 18;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 13, labelWidth, nameLabelFont)];
        [nameLabel setFont:[UIFont fontWithName:LIGHT_FONT size:nameLabelFont]];
        [nameLabel setTextColor:[UIColor colorFromHexCode:@"353535"]];
        [self addSubview:nameLabel];
        
        int auxLabelFont = 18;
        auxLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, padding + nameLabel.frame.origin.y + nameLabel.frame.size.height, labelWidth, auxLabelFont + 5)];
        [auxLabel setFont:[UIFont fontWithName:BOLD_FONT size:auxLabelFont]];
        [auxLabel setTextColor:[UIColor darkGrayColor]];
        [self addSubview:auxLabel];
        
        int arrowLabelFont = 20;
        arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - padding - arrowLabelFont, imageSize - padding, arrowLabelFont, arrowLabelFont)];
        [arrowLabel setFont:[UIFont fontWithName:BOLD_FONT size:auxLabelFont]];
        [arrowLabel setTextColor:[UIColor darkGrayColor]];
        [arrowLabel setText:@"❯"];
        arrowLabel.alpha = 0;
        [self addSubview:arrowLabel];
        
        self.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

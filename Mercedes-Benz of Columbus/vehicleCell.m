//
//  vehicleCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/24/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "vehicleCell.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"

@implementation vehicleCell
@synthesize photoImageView;
@synthesize nameLabel;
@synthesize priceLabel;
@synthesize auxLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[self layer] setShouldRasterize:YES];
        [[self layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        
        int padding = 10;
        int imageSize = 88;
        
        photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSize, imageSize)];
        [photoImageView setContentMode:UIViewContentModeScaleAspectFill];
        [photoImageView setClipsToBounds:YES];
        [self addSubview:photoImageView];

        int labelWidth = [UIScreen mainScreen].bounds.size.width - padding - photoImageView.frame.size.width;
        int labelX = 102;
        
        int nameLabelFont = 18;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 13, labelWidth, nameLabelFont)];
        [nameLabel setFont:[UIFont fontWithName:REGULAR_FONT size:nameLabelFont]];
        [nameLabel setTextColor:[UIColor colorFromHexCode:@"353535"]];
        [self addSubview:nameLabel];
        
        int priceLabelFont = 13;
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, padding + nameLabel.frame.origin.y + nameLabel.frame.size.height, labelWidth, priceLabelFont)];
        [priceLabel setFont:[UIFont fontWithName:SEMI_BOLD_FONT size:priceLabelFont]];
        [priceLabel setTextColor:[UIColor greenSeaColor]];
        [self addSubview:priceLabel];
        
        int auxLabelFont = 11;
        auxLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, padding + priceLabel.frame.origin.y + priceLabel.frame.size.height, labelWidth, auxLabelFont + 5)];
        [auxLabel setFont:[UIFont fontWithName:REGULAR_FONT size:auxLabelFont]];
        [auxLabel setTextColor:[UIColor darkGrayColor]];
        [self addSubview:auxLabel];
        
        self.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

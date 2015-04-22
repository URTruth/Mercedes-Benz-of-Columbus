//
//  serviceCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "serviceCell.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"

@implementation serviceCell
@synthesize descriptionLabel;
@synthesize dateLabel;
@synthesize auxLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[self layer] setShouldRasterize:YES];
        [[self layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        
        int padding = 10;
        int labelWidth = [UIScreen mainScreen].bounds.size.width - padding;
        int labelX = 13;
        
        int descriptionLabelFont = 18;
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 13, labelWidth, descriptionLabelFont)];
        [descriptionLabel setFont:[UIFont fontWithName:REGULAR_FONT size:descriptionLabelFont]];
        [descriptionLabel setTextColor:[UIColor colorFromHexCode:@"353535"]];
        [self addSubview:descriptionLabel];
        
        int dateLabelFont = 13;
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, padding + descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height, labelWidth, dateLabelFont)];
        [dateLabel setFont:[UIFont fontWithName:SEMI_BOLD_FONT size:dateLabelFont]];
        [dateLabel setTextColor:[UIColor greenSeaColor]];
        [self addSubview:dateLabel];
        
        int auxLabelFont = 11;
        auxLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, padding + dateLabel.frame.origin.y + dateLabel.frame.size.height, labelWidth, auxLabelFont + 5)];
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

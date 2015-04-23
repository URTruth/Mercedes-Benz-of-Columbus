//
//  videoCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/20/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "videoCell.h"
#import "Common.h"
#import "UIColor+Custom.h"

#import "UIColor+FlatUI.h"

@implementation videoCell
@synthesize photoImageView;
@synthesize nameLabel;
@synthesize descriptionTextView;

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
        [nameLabel setFont:[UIFont fontWithName:BOLD_FONT size:nameLabelFont]];
        [nameLabel setTextColor:[UIColor colorFromHexCode:@"353535"]];
        [self addSubview:nameLabel];
        
        int descriptionTextViewFont = 15;
        descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(labelX - 4, padding - 10 + nameLabel.frame.origin.y + nameLabel.frame.size.height, labelWidth, descriptionTextViewFont * 3)];
        [descriptionTextView setFont:[UIFont fontWithName:REGULAR_FONT size:descriptionTextViewFont]];
        [descriptionTextView setTextColor:[UIColor darkGrayColor]];
        [descriptionTextView setBackgroundColor:[UIColor colorFromHexCode:@"f5f5f5"]];
        [descriptionTextView setUserInteractionEnabled:NO];
        [self addSubview:descriptionTextView];
        
        self.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

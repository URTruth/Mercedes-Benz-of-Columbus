//
//  menuCell.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/22/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "menuCell.h"

@implementation menuCell
@synthesize viewsDictionary;
@synthesize iconImageView;
@synthesize nameLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[self layer] setShouldRasterize:YES];
        [[self layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        
        iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleToFill;
        [iconImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:iconImageView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 33, 200, 20)];
        [nameLabel setTextColor: [UIColor lightGrayColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        //[nameLabel setFont:[UIFont fontWithName: CHIIME_REGULAR_FONT size: 10.0f]];
        [nameLabel setFont:[UIFont fontWithName: @"Avenir-Next" size: 10.0f]];
        [self addSubview:nameLabel];
        
        [iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        viewsDictionary = NSDictionaryOfVariableBindings(iconImageView, nameLabel);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[iconImageView]" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[nameLabel]" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[iconImageView]-14.5-[nameLabel]" options:0 metrics:nil views:viewsDictionary]];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

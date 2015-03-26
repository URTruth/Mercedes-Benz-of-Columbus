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
@synthesize webView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 350, 250)];
        webView.scrollView.scrollEnabled = NO;
        [webView setContentMode:UIViewContentModeScaleAspectFill];
        [webView setClipsToBounds:YES];
        [self addSubview:webView];
        
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

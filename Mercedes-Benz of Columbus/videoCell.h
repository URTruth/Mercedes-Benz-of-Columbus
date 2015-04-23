//
//  videoCell.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/20/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoCell : UITableViewCell

+ (videoCell *)cell;

@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;

@end

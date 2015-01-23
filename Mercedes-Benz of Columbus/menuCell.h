//
//  menuCell.h
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 1/22/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuCell : UITableViewCell

@property (retain, nonatomic) NSDictionary *viewsDictionary;
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;

@end

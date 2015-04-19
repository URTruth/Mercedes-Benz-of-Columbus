//
//  serviceCell.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 4/10/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface serviceCell : UITableViewCell

+ (serviceCell *)cell;

@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *auxLabel;
@property (nonatomic, retain) IBOutlet UILabel *arrowLabel;


@end

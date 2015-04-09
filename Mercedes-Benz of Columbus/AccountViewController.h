//
//  AccountViewController.h
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UITableViewController <UITableViewDelegate, UIGestureRecognizerDelegate>
{
    int selectedRow;
}

@property(nonatomic, strong) NSMutableArray *menuData;

@end

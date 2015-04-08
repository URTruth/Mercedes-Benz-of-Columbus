//
//  VehicleViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Kelvin Graddick on 2/11/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "VehicleViewController.h"
#import "vehicleCell.h"
#import "Common.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"

@interface VehicleViewController ()

@end

@implementation VehicleViewController
@synthesize vin;
@synthesize vehicleData;
@synthesize vehicleImageView;
@synthesize vehicleNameLabel;
@synthesize vehiclePriceLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-65,0,0,0);
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self refresh];
    
 }

- (void)viewDidAppear:(BOOL)animated {
    //id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //[tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Vehicle page" forKey:kGAIScreenName] build]];
}

- (void)refresh {
    // Send a asynchronous request for the initial menu data
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"vin": vin};
    [manager POST:@"http://www.wavelinkllc.com/mboc/get_vehicle.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        vehicleData = responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return 1;
        case 3: return 1;
        case 4: return 1;
        case 5: return 1;
        case 6: return 1;
        case 7: return 1;
        case 8: return 1;
        case 9: return 1;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* vehicleItem = [vehicleData objectAtIndex:0];
    
    if(indexPath.section == 0) {
        return [Common headerOfType:Default withTitle:[vehicleItem objectForKey:@"name"] withIcon:[UIImage imageNamed:@"showroom.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]];
    }
    
    if(indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presentationCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"presentationCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
            
            vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
            [vehicleImageView setContentMode:UIViewContentModeScaleAspectFill];
            [cell addSubview:vehicleImageView];
            
            UIImageView *text_veil = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
            [text_veil setContentMode:UIViewContentModeScaleAspectFill];
            [text_veil setImage:[UIImage imageNamed:@"text-veil.png"]];
            [cell addSubview:text_veil];
            
            int vehicleNameFont = 24;
            vehicleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, text_veil.frame.size.height/4/1.75, [UIScreen mainScreen].bounds.size.width - 40, vehicleNameFont)];
            [vehicleNameLabel setFont:[UIFont fontWithName:LIGHT_FONT size:vehicleNameFont]];
            [vehicleNameLabel setTextColor:[UIColor whiteColor]];
            [text_veil addSubview:vehicleNameLabel];
            
            int vehiclePriceFont = 17;
            vehiclePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, vehicleNameLabel.frame.origin.y + vehicleNameLabel.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width/2 - 20, vehiclePriceFont)];
            [vehiclePriceLabel setFont:[UIFont fontWithName:BOLD_FONT size:vehiclePriceFont]];
            [vehiclePriceLabel setTextColor:[UIColor greenSeaColor]];
            [text_veil addSubview:vehiclePriceLabel];
        }
        
        NSArray *images = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [vehicleImageView setImageWithURL:[NSURL URLWithString:[images objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"no-vehicle-image.png"]];
        
        [vehicleNameLabel setText:[vehicleItem objectForKey:@"name"]];
        
        [vehiclePriceLabel setText:[vehicleItem objectForKey:@"price"]];
        
        return cell;
    }
    
    if(indexPath.section == 2) {
        
        
    }
    
    if(indexPath.section == 3) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
      
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"exterior.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
        cell.nameLabel.text = @"Exterior Color";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"color"]]];

        return cell;

    }
    
    if(indexPath.section == 4) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"interior_color.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
         cell.nameLabel.text = @"Interior Color";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"color"]]];
        
        return cell;
        
    }

    if(indexPath.section == 5) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"interior.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
         cell.nameLabel.text = @"Interior Description";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"body"]]];

        return cell;
        
    }
    
    if(indexPath.section == 6) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"showroom.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
         cell.nameLabel.text = @"Body Description";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"body"]]];
        
        return cell;
        
    }
    
    if(indexPath.section == 7) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"mileage.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
         cell.nameLabel.text = @"Mileage";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"body"]]];

        return cell;
        
    }

    if(indexPath.section == 8) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"parts.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
         cell.nameLabel.text = @"Stock Number";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"body"]]];
        
        return cell;
        
    }

    if(indexPath.section == 9) {
        static NSString *vehicleCellIdentifier = @"vehicleCell";
        vehicleCell *cell = (vehicleCell *)[tableView dequeueReusableCellWithIdentifier:vehicleCellIdentifier];
        if (cell == nil){ cell = [[vehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vehicleCellIdentifier]; }
        
        
        NSArray *image = (![[vehicleItem objectForKey:@"urls"] isEqual:[NSNull null]]) ? [[vehicleItem objectForKey:@"urls"] componentsSeparatedByString: @","] : [[NSArray alloc] initWithObjects:@"", nil];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:[image objectAtIndex: 0]] placeholderImage:[UIImage imageNamed:@"barcode.png"]];
        cell.nameLabel.font = [UIFont fontWithName:LIGHT_FONT size:22.0f];
         cell.nameLabel.text = @"VIN";
        cell.auxLabel.font = [UIFont fontWithName:BOLD_FONT size:16.0f];
        [cell.auxLabel setText:[NSString stringWithFormat:@"%@", [vehicleItem objectForKey:@"vin"]]];

        return cell;
        
    }

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blankCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 122;
    }
    if(indexPath.section == 1) {
        return [UIScreen mainScreen].bounds.size.width;
    }
    if(indexPath.section == 2) {
        return 0;
    }
    if(indexPath.section == 3) {
        return 88;
    }
    if(indexPath.section == 4) {
        return 88;
    }
    if(indexPath.section == 5) {
        return 88;
    }
    if(indexPath.section == 6) {
        return 88;
    }
    if(indexPath.section == 7) {
        return 88;
    }
    if(indexPath.section == 8) {
        return 88;
    }
    if(indexPath.section == 9) {
        return 88;
    }

    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) {
        NSDictionary* vehicleItem = [vehicleData objectAtIndex:indexPath.row];
        vin = [vehicleItem objectForKey:@"vin"];
        [self performSegueWithIdentifier:@"vehicleSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"vehicleSegue"]){
        VehicleViewController *dest = (VehicleViewController *)[segue destinationViewController];
        dest.vin = vin;
    }
}

- (IBAction)optionsButtonClicked:(id)sender {
    //TODO: add actionsheet here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  homePageViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 12/1/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "homePageViewController.h"
#import "contactViewController.h"
#import "locationViewController.h"

@interface homePageViewController ()

@end

@implementation homePageViewController
{
    NSArray *tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName: @"AvenirNext-Medium" size: 18.0f]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    
    CGRect myImage = CGRectMake( 5.0f, 0.0f, 370.0f, 90.0f);
    UIImageView *logo = [[UIImageView alloc]initWithFrame:myImage];
    [logo setImage:[UIImage imageNamed:@"logo.jpg"]];
    [self.view addSubview:logo];
    
    // Do any additional setup after loading the view.
    tableData = [NSArray arrayWithObjects:@" ", @" ", @" ", @"New Inventory", @"Used Inventory", @"Specials", @"Book a Service", @"Location & Hours", @"Contact Us", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[tableData objectAtIndex:indexPath.row] isEqualToString:@"Contact Us"]) {
        [self performSegueWithIdentifier:@"contactSegue" sender:self];
    }
    if([[tableData objectAtIndex:indexPath.row] isEqualToString:@"Location & Hours"]) {
        [self performSegueWithIdentifier:@"contactSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"contactSegue"]){
        contactViewController *dest = (contactViewController *)[segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"locationSegue"]){
        locationViewController *dest = (locationViewController *)[segue destinationViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

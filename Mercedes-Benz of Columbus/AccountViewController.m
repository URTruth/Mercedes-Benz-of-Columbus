//
//  AccountViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/4/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "AccountViewController.h"
#import "Common.h"

#import "UIColor+FlatUI.h"


@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize backgroundImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 360, 600)];
    
    NSInteger viewcount= 4;
    for (int i = 0; i <viewcount; i++)
    {
        CGFloat y = i * self.view.frame.size.height;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y,                                                      self.view.frame.size.width, self .view.frame.size.height)];
        view.backgroundColor = [UIColor greenColor];
        [self.view addSubview:scrollview];
    }
    scrollview.contentSize = CGSizeMake(350, 180 *viewcount);
    
    
    self.navigationItem.backBarButtonItem = [[Common alloc] backButton];
    
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
    
    [self.view addSubview:[[Common alloc] headerWithTitle:@"My Account" withIcon:[UIImage imageNamed:@"account.png"]]];
    
    
    UIBarButtonItem *optionsButton = [[Common alloc] optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 122, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setImage:[UIImage imageNamed:@"montage.png"]];
    [self.view addSubview:backgroundImage];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

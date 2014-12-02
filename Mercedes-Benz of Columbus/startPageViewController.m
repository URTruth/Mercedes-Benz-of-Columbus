//
//  startPageViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 12/1/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "startPageViewController.h"

@interface startPageViewController ()

@end

@implementation startPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect myImageRect = CGRectMake( 10.0f, 25.0f, 350.0f, 140.0f);
    UIImageView *myImage = [[UIImageView alloc]initWithFrame:myImageRect];
    [myImage setImage:[UIImage imageNamed:@"MercedesLogo.png"]];
    //[self.view addSubview:myImage];
    
    CGRect myImageRect2 = CGRectMake( 10.0f, 570.0f, 355.0f, 90.0f);
    UIImageView *myImage2 = [[UIImageView alloc]initWithFrame:myImageRect2];
    [myImage2 setImage:[UIImage imageNamed:@"image.jpg"]];
    //[self.view addSubview:myImage2];
    
    //    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    //btn.backgroundColor = [UIColor colorWithRed:41/255.0f green:128/255.0f blue:185/255.0f alpha:1.0f]; //2980B9
    //    btn.frame = CGRectMake(65, 250, 250, 40);
    //    btn.clipsToBounds = YES;
    //    btn.layer.cornerRadius = 3;
    //    btn.layer.shadowOffset = CGSizeMake(1, -2);
    //    btn.layer.shadowRadius = 1;
    //    btn.layer.shadowOpacity = 0.2;
    //    [btn setTitle:@"Take A Tour" forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor colorWithRed:46/255.0f green:184/255.0f blue:184/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //    [btn setFont:[UIFont fontWithName:@"Arial" size:20]];
    //   // [btn addTarget:self action:@selector(<#selector#>)(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.backgroundColor = [UIColor colorWithRed:41/255.0f green:128/255.0f blue:185/255.0f alpha:1.0f]; //2980B9
    btn1.frame = CGRectMake(65, 350, 250, 40);
    btn1.clipsToBounds = YES;
    btn1.layer.cornerRadius = 3;
    btn1.layer.shadowOffset = CGSizeMake(1, -2);
    btn1.layer.shadowRadius = 4;
    btn1.layer.shadowOpacity = 0.4;
    [btn1 setTitle:@"Connect With Facebook" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //[self.view addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]; //#000000
    btn2.frame = CGRectMake(65, 400, 250, 40);
    btn2.clipsToBounds = YES;
    btn2.layer.cornerRadius = 3;
    btn2.layer.shadowOffset = CGSizeMake(1, -2);
    btn2.layer.shadowRadius = 4;
    btn2.layer.shadowOpacity = 0.4;
    [btn2 setTitle:@"Connect With Google" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //[self.view addSubview:btn2];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.backgroundColor = [UIColor colorWithRed:46/255.0f green:184/255.0f blue:184/255.0f alpha:1.0f]; //#2eb8b8
    btn3.frame = CGRectMake(65, 450, 250, 40);
    btn3.clipsToBounds = YES;
    btn3.layer.cornerRadius = 3;
    btn3.layer.shadowOffset = CGSizeMake(1, -2);
    btn3.layer.shadowRadius = 4;
    btn3.layer.shadowOpacity = 0.4;
    [btn3 setTitle:@"Connect With Email" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //[self.view addSubview:btn3];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  startPageViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 12/1/14.
//  Copyright (c) 2014 Wave Link, LLC. All rights reserved.
//

#import "startPageViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface startPageViewController ()
{
    AVAudioPlayer *_audioPlayer;
}


@end

@implementation startPageViewController
@synthesize backgroundImageView;
@synthesize startButtonImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int backgroundImageViewSize = [UIScreen mainScreen].bounds.size.height;
    backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-((backgroundImageViewSize - [UIScreen mainScreen].bounds.size.width)/2), 0, backgroundImageViewSize, backgroundImageViewSize)];
    [backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImageView setImage:[UIImage imageNamed:@"backgroundC.png"]];
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [tapRecognizer setDelegate:self];
    startButtonImageView.userInteractionEnabled = YES;
    [startButtonImageView addGestureRecognizer:tapRecognizer];
    
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
    
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/CarCrank.m4a", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Home page" forKey:kGAIScreenName] build]];
}

- (void)start {
    [_audioPlayer play];
    [self performSegueWithIdentifier:@"homeSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

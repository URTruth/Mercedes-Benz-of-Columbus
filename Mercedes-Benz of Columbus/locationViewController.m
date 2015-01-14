//
//  locationViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 1/12/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "locationViewController.h"
#import <MapKit/MapKit.h>

@interface locationViewController ()

@end

@implementation locationViewController

- (void)viewDidAppear:(BOOL)animated {
    // main view background color
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 365, 600)];
    
    NSInteger viewcount= 4;
    for (int i = 0; i <viewcount; i++)
    {
        CGFloat y = i * self.view.frame.size.height;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y,                                                      self.view.frame.size.width, self .view.frame.size.height)];
        view.backgroundColor = [UIColor greenColor];
        [self.view addSubview:scrollview];
    }
    scrollview.contentSize = CGSizeMake(350, 200 *viewcount);
    
    //checkbox == 0;
    
    self.navigationItem.hidesBackButton = YES;
    
    
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName: @"AvenirNext-DemiBold" size: 14.0f]} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButton;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;

    //top image with logo
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 122)];
    [bgImage setImage:[UIImage imageNamed:@"montage.png"]];
    [bgImage setContentMode:UIViewContentModeScaleAspectFill];
    [bgImage setClipsToBounds:YES];
    [self.view addSubview:bgImage];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, -22, 200, 150)];
    [logo setImage:[UIImage imageNamed:@"logo-tagline-white.png"]];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:logo];

    // gray background centerview
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(10, 135, 365, 600)];
    [centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    centerView.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f];
    [scrollview addSubview:centerView];
    
    MKMapView * map = [[MKMapView alloc] initWithFrame: CGRectMake(13, 10, 328, 280)];
    
    map.delegate = self;
    
    [centerView addSubview:map];
  
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Sales", @"Service", @"Parts", nil]];
        segmentedControl.frame = CGRectMake(25, 303, 300, 30);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.tintColor = [UIColor blackColor];
        [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
        [centerView addSubview:segmentedControl];
        
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label.backgroundColor = [UIColor clearColor]; //2980B9
    label.frame = CGRectMake(15, 340, 300, 20);
    label.clipsToBounds = YES;
    label.text = @"Mercedes-Benz of Columbus - Sales";
    [label setTextAlignment: UITextAlignmentLeft];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    label.textColor=[UIColor blackColor];
    [centerView addSubview:label];

    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label1.backgroundColor = [UIColor clearColor]; //2980B9
    label1.frame = CGRectMake(15, 345, 300, 50);
    label1.clipsToBounds = YES;
    label1.text = @"7470 Veterans Parkway, Columbus GA 31909";
    [label1 setTextAlignment: UITextAlignmentLeft];
    [label1 setFont:[UIFont systemFontOfSize:12]];
    label1.textColor=[UIColor blackColor];
    [centerView addSubview:label1];

    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label2.backgroundColor = [UIColor clearColor]; //2980B9
    label2.frame = CGRectMake(15, 375, 300, 50);
    label2.clipsToBounds = YES;
    label2.text = @"GEO: 32.5311, -84.9567";
    [label2 setTextAlignment: UITextAlignmentLeft];
    [label2 setFont:[UIFont systemFontOfSize:12]];
    label2.textColor=[UIColor blackColor];
    [centerView addSubview:label2];

    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label3.backgroundColor = [UIColor clearColor]; //2980B9
    label3.frame = CGRectMake(15, 395, 300, 50);
    label3.clipsToBounds = YES;
    label3.text = @"Tel: 706-256-6100";
    [label3 setTextAlignment: UITextAlignmentLeft];
    [label3 setFont:[UIFont systemFontOfSize:12]];
    label3.textColor=[UIColor blackColor];
    [centerView addSubview:label3];
    
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    label4.backgroundColor = [UIColor clearColor]; //2980B9
    label4.frame = CGRectMake(15, 415, 300, 50);
    label4.clipsToBounds = YES;
    label4.text = @"Hours of Operation";
    [label4 setTextAlignment: UITextAlignmentLeft];
    [label4 setFont:[UIFont boldSystemFontOfSize:14]];
    label4.textColor=[UIColor colorWithRed:4/255.0f green:102/255.0f blue:221/255.0f alpha:1.0f];
    [centerView addSubview:label4];
    
    UILabel * mon = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    mon.backgroundColor = [UIColor clearColor]; //2980B9
    mon.frame = CGRectMake(15, 435, 300, 50);
    mon.clipsToBounds = YES;
    mon.text = @"Monday                                9am - 7pm";
    [mon setTextAlignment: UITextAlignmentLeft];
    [mon setFont:[UIFont systemFontOfSize:12]];
    mon.textColor=[UIColor blackColor];
    [centerView addSubview:mon];
    
    UILabel * tues = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    tues.backgroundColor = [UIColor clearColor]; //2980B9
    tues.frame = CGRectMake(15, 455, 300, 50);
    tues.clipsToBounds = YES;
    tues.text = @"Tuesday                                9am - 7pm";
    [tues setTextAlignment: UITextAlignmentLeft];
    [tues setFont:[UIFont systemFontOfSize:12]];
    tues.textColor=[UIColor blackColor];
    [centerView addSubview:tues];
    
    UILabel * wed = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    wed.backgroundColor = [UIColor clearColor]; //2980B9
    wed.frame = CGRectMake(15, 475, 300, 50);
    wed.clipsToBounds = YES;
    wed.text = @"Wednesday                          9am - 7pm";
    [wed setTextAlignment: UITextAlignmentLeft];
    [wed setFont:[UIFont systemFontOfSize:12]];
    wed.textColor=[UIColor blackColor];
    [centerView addSubview:wed];
    
    UILabel * thur = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    thur.backgroundColor = [UIColor clearColor]; //2980B9
    thur.frame = CGRectMake(15, 495, 300, 50);
    thur.clipsToBounds = YES;
    thur.text = @"Thursday                              9am - 7pm";
    [thur setTextAlignment: UITextAlignmentLeft];
    [thur setFont:[UIFont systemFontOfSize:12]];
    thur.textColor=[UIColor blackColor];
    [centerView addSubview:thur];
    
    UILabel * fri = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    fri.backgroundColor = [UIColor clearColor]; //2980B9
    fri.frame = CGRectMake(15, 515, 300, 50);
    fri.clipsToBounds = YES;
    fri.text = @"Friday                                  9am - 7pm";
    [fri setTextAlignment: UITextAlignmentLeft];
    [fri setFont:[UIFont systemFontOfSize:12]];
    fri.textColor=[UIColor blackColor];
    [centerView addSubview:fri];
    
    UILabel * sat = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    sat.backgroundColor = [UIColor clearColor]; //2980B9
    sat.frame = CGRectMake(15, 535, 300, 50);
    sat.clipsToBounds = YES;
    sat.text = @"Saturday                              9am - 6pm";
    [sat setTextAlignment: UITextAlignmentLeft];
    [sat setFont:[UIFont systemFontOfSize:12]];
    sat.textColor=[UIColor blackColor];
    [centerView addSubview:sat];
    
    UILabel * sun = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 0)];
    sun.backgroundColor = [UIColor clearColor]; //2980B9
    sun.frame = CGRectMake(15, 555, 300, 50);
    sun.clipsToBounds = YES;
    sun.text = @"Sunday                          Closed All Day";
    [sun setTextAlignment: UITextAlignmentLeft];
    [sun setFont:[UIFont systemFontOfSize:12]];
    sun.textColor=[UIColor blackColor];
    [centerView addSubview:sun];
    
//    CLLocationCoordinate2D annotationCoord;
//    
//    annotationCoord.latitude = 37.640071;
//    annotationCoord.longitude = -75.129598;
//    
//    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
//    annotationPoint.coordinate = annotationCoord;
//    annotationPoint.title = @"Microsoft";
//    annotationPoint.subtitle = @"Microsoft's headquarters";
//    [map addAnnotation:annotationPoint];

}

- (void)valueChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        //action for the first button (All)
     
        
    }else if(segment.selectedSegmentIndex == 1){
        //action for the second button (Present)
        
    }else if(segment.selectedSegmentIndex == 2){
        //action for the third button (Missing)
        self.view.backgroundColor = [UIColor blueColor];
    }
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

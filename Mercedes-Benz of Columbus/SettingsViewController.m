//
//  SettingsViewController.m
//  Mercedes-Benz of Columbus
//
//  Created by Danielle Williams on 2/6/15.
//  Copyright (c) 2015 Wave Link, LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "AccountViewController.h"
#import "Common.h"
#import "User.h"

#import "ProgressHUD.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIColor+FlatUI.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "GAIFields.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize backgroundView;
@synthesize scrollView;
@synthesize nameTextBox;
@synthesize emailTextBox;
@synthesize phoneTextBox;
@synthesize vinTextBox;
@synthesize photoImageView;
@synthesize placeholderImageView;
@synthesize searchButton;
@synthesize saveButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.view addSubview:backgroundView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1200);
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer: tapRec];
    
    self.navigationItem.backBarButtonItem = [Common backButton];
    
    self.navigationController.navigationBar.tintColor = [Common navigationBarTintColor];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    CGRect frame = self.view.frame;
    frame.size.height += 65;
    self.view.frame = frame;
    self.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.titleView = nil;
    
    [self.view addSubview:[Common headerWithTitle:@"Settings" withIcon:[UIImage imageNamed:@"engine.png"] withBackground:[UIImage imageNamed:@"backgroundA.png"]]];
    
    UIBarButtonItem *optionsButton = [Common optionsButtonWithTarget:self andAction:@selector(optionsButtonClicked:)];
    self.tabBarController.navigationItem.rightBarButtonItem = optionsButton;
    //self.navigationItem.rightBarButtonItem = optionsButton;
    
    int buttonHeight = 50;
    int textBoxHeight = 40;
    
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 40, 145, 80, 80)];
    photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    photoImageView.layer.cornerRadius = 40;
    [photoImageView.layer setMasksToBounds:YES];
    photoImageView.userInteractionEnabled = YES;
    [scrollView addSubview:photoImageView];
    
    placeholderImageView = [[UIImageView alloc] initWithFrame:photoImageView.frame];
    placeholderImageView.contentMode = UIViewContentModeScaleAspectFill;
    placeholderImageView.layer.cornerRadius = 40;
    [placeholderImageView.layer setMasksToBounds:YES];
    placeholderImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *photoTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoButtonClicked:)];
    [photoTapRecognizer setNumberOfTouchesRequired:1];
    [photoTapRecognizer setDelegate:self];
    [placeholderImageView addGestureRecognizer:photoTapRecognizer];
    [placeholderImageView setImage:[UIImage imageNamed:@"account.png"]];
    [scrollView addSubview:placeholderImageView];
    
    vinTextBox = [Common textBoxWithPlaceholder:@"Enter VIN number.." frame:CGRectMake(20, photoImageView.frame.origin.y + photoImageView.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:vinTextBox];
    
    nameTextBox = [Common textBoxWithPlaceholder:@"Enter name.." frame:CGRectMake(20, vinTextBox.frame.origin.y + vinTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:nameTextBox];
    
    emailTextBox = [Common textBoxWithPlaceholder:@"Enter email.." frame:CGRectMake(20, nameTextBox.frame.origin.y + nameTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:emailTextBox];
    
    phoneTextBox = [Common textBoxWithPlaceholder:@"Enter phone.." frame:CGRectMake(20, emailTextBox.frame.origin.y + emailTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, textBoxHeight) target:self];
    [scrollView addSubview:phoneTextBox];
    
    searchButton = [Common buttonWithText:@"Find VIN number" color:[UIColor sunflowerColor] frame:CGRectMake(20, phoneTextBox.frame.origin.y + phoneTextBox.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, buttonHeight)];
    UITapGestureRecognizer *searchTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchButtonClicked:)];
    [searchTapRecognizer setNumberOfTouchesRequired:1];
    [searchTapRecognizer setDelegate:self];
    [searchButton addGestureRecognizer:searchTapRecognizer];
    [scrollView addSubview:searchButton];
    
    saveButton = [Common buttonWithText:@"Save" color:[UIColor turquoiseColor] frame:CGRectMake(20, searchButton.frame.origin.y + searchButton.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width - 40, buttonHeight)];
    UITapGestureRecognizer *saveTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveButtonClicked:)];
    [saveTapRecognizer setNumberOfTouchesRequired:1];
    [saveTapRecognizer setDelegate:self];
    [saveButton addGestureRecognizer:saveTapRecognizer];
    [scrollView addSubview:saveButton];
    
    nameTextBox.text = [User sharedInstance].name;
    emailTextBox.text = [User sharedInstance].email;
    phoneTextBox.text = [User sharedInstance].phone;
    vinTextBox.text = [User sharedInstance].vin;
    if([User sharedInstance].photo != nil && [User sharedInstance].photo.length > 0){
        placeholderImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[Common webServiceUrlWithPath:[User sharedInstance].photo]]]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Settings page" forKey:kGAIScreenName] build]];
}

- (IBAction)saveButtonClicked:(id)sender {
    [self disableControls];
    [ProgressHUD show:@"Hey! We're validating..."];
    if(photoImageView.image == nil)
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"userId":ObjectOrNull([User sharedInstance].userId), @"name": nameTextBox.text, @"email": emailTextBox.text, @"phone": phoneTextBox.text, @"vin": vinTextBox.text};
        [manager POST:[Common webServiceUrlWithPath:@"save_settings.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleSaveResponse:operation object:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleSaveFailure:operation error:error];
        }];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"userId":ObjectOrNull([User sharedInstance].userId), @"name": nameTextBox.text, @"email": emailTextBox.text, @"phone": phoneTextBox.text, @"vin": vinTextBox.text};
        UIImage *imageToUpload = [Common scaleAndRotateImage:photoImageView.image];
        NSData *imageData = UIImageJPEGRepresentation(imageToUpload, 1.0);
        [manager POST:[Common webServiceUrlWithPath:@"save_settings.php"] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"profile.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleSaveResponse:operation object:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleSaveFailure:operation error:error];
        }];
    }
}

- (void)handleSaveResponse:(AFHTTPRequestOperation *)operation object:(id)responseObject {
    NSDictionary *responseData = (NSDictionary*)responseObject;
    if ([[responseData objectForKey:@"response"] isEqualToString:@"SUCCESS"]){
        [[User sharedInstance] login:^(BOOL isSuccess) {
            if(isSuccess) {
                [ProgressHUD showSuccess:@"Success! Your settings were saved!"];
                
            } else {
                [ProgressHUD dismiss];
                [Common showErrorMessageWithTitle:@"Save was unsuccessful." message:@"Please try again." cancelButtonTitle:@"OK"];
            }
            [self enableControls];
        }];
    }else{
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:[responseData objectForKey:@"response"] message:@"Please retry." cancelButtonTitle:@"OK"];
        [self enableControls];
    }
}

- (void)handleSaveFailure:(AFHTTPRequestOperation *)operation error:(NSError*)error {
    [ProgressHUD dismiss];
    [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
    [self enableControls];
}

- (IBAction)searchButtonClicked:(id)sender {
    [self disableControls];
    [ProgressHUD show:@"Searching..."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": emailTextBox.text, @"phone": phoneTextBox.text};
    [manager POST:[Common webServiceUrlWithPath:@"get_vin.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject count] > 0) {
            vinTextBox.text = [[responseObject objectAtIndex:0] objectForKey:@"vin"];
            [ProgressHUD showSuccess:@"Success! Your VIN number was loaded."];
        } else {
            [ProgressHUD dismiss];
            [Common showErrorMessageWithTitle:@"VIN search was unsuccessful." message:@"Change the search information and try again. Only VIN numbers of vehicles sold at Mercedes-Benz of Columbus, Georgia are available." cancelButtonTitle:@"OK"];
        }
        [self enableControls];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [Common showErrorMessageWithTitle:@"Oops! Could not connect." message:@"Please check your internet connection." cancelButtonTitle:@"OK"];
        [self enableControls];
    }];
}

- (void)disableControls {
    photoImageView.userInteractionEnabled = NO;
    placeholderImageView.userInteractionEnabled = NO;
    searchButton.enabled = NO;
    vinTextBox.enabled = NO;
    nameTextBox.enabled = NO;
    emailTextBox.enabled = NO;
    phoneTextBox.enabled = NO;
    saveButton.enabled = NO;
}

- (void)enableControls {
    photoImageView.userInteractionEnabled = YES;
    placeholderImageView.userInteractionEnabled = YES;
    searchButton.enabled = YES;
    vinTextBox.enabled = YES;
    nameTextBox.enabled = YES;
    emailTextBox.enabled = YES;
    phoneTextBox.enabled = YES;
    saveButton.enabled = YES;
}

- (IBAction)addPhotoButtonClicked:(id)sender {
    UIActionSheet *actionSheet1 = [[UIActionSheet alloc]
                                   initWithTitle: @"Profile picture"
                                   delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   destructiveButtonTitle: nil
                                   otherButtonTitles:@"Take Photo", @"Choose Photo",nil];
    actionSheet1.tag = 1;
    [actionSheet1 showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == 1) {
        //take photo
        if (buttonIndex == 0)
        {
            NSLog(@"Take Photo");
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            [picker setSourceType: UIImagePickerControllerSourceTypeCamera ];
            [self presentViewController: picker animated: YES completion: NULL];
        }
        //displays photo library
        if (buttonIndex == 1)
        {
            NSLog(@"Choose Photo");
            picker2 = [[UIImagePickerController alloc] init];
            picker2.delegate = self;
            //picker2.allowsEditing = YES;
            [picker2 setSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController: picker2 animated: YES completion: NULL];
        }
        
    }
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        //( image = [info objectForKey: UIImagePickerControllerEditedImage]);
        //[profilePicImageView setImage:image];
        
        //[myScrollView setScrollEnabled:NO];
        [self dismissViewControllerAnimated:YES completion:NULL];
        ( image = [info objectForKey: UIImagePickerControllerOriginalImage]);
        VPImageCropperViewController *imageCropper = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imageCropper.delegate = self;
        [self presentViewController:imageCropper animated:YES completion:nil];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [photoImageView setImage:editedImage];
    [placeholderImageView setImage:nil];
    [scrollView setScrollEnabled:NO];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if (sender.frame.origin.y > 100)
    {
        [scrollView setContentOffset:CGPointMake(0, sender.frame.origin.y-100) animated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == vinTextBox && ![textField.text isEqualToString:@""]) {
        
    }
    return YES;
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"accountSegue"]){
        AccountViewController *dest = (AccountViewController *)[segue destinationViewController];
    }
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

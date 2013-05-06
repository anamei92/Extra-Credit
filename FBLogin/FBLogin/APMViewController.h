//
//  APMViewController.h
//  FBLogin
//
//  Created by Ana Mei on 5/5/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APMViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *myImg;
@property (weak, nonatomic) IBOutlet UITextField *myStatus;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIButton *UploadPhoto;
@property (weak, nonatomic) IBOutlet UIButton *UpdateStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *DoneEdit;
@property (weak, nonatomic) IBOutlet UIButton *RandomButton;
@property (nonatomic, strong) NSArray *displayImages;


- (IBAction)uploadPhoto:(id)sender;
- (IBAction)updateStatus:(id)sender;
- (IBAction)completeEdit:(id)sender;
- (IBAction)randomPhoto:(id)sender;


@end

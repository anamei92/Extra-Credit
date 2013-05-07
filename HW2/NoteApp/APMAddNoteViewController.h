//
//  APMAddNoteViewController.h
//  NoteApp
//
//  Created by Ana Mei on 3/15/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class APMTableMainController;

@interface APMAddNoteViewController : UITableViewController
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;


@property (strong, nonatomic) APMTableMainController *mainNotesController;
- (IBAction)pressedDone:(id)sender;
- (IBAction)pressedCancel:(id)sender;

@end

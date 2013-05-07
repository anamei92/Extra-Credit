//
//  APMEditNoteViewController.h
//  NoteApp
//
//  Created by Ana Mei on 3/15/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "SaveNote.h"

@interface APMEditNoteViewController : UITableViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextView *describe;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) SaveNote *note;

- (IBAction)changedName:(id)sender;
@end

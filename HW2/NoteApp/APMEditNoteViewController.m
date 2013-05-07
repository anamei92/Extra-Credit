//
//  APMEditNoteViewController.m
//  NoteApp
//
//  Created by Ana Mei on 3/15/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import "APMEditNoteViewController.h"
#import "APMNote.h"
#import "APMAppDelegate.h"

@interface APMEditNoteViewController ()
@property (strong, nonatomic) APMAppDelegate *appDelegate;
@end

@implementation APMEditNoteViewController
@synthesize nameField = _nameField;
@synthesize describe =_describe;
@synthesize note = _note;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.nameField.text = self.note.title;
    self.describe.text = self.note.text;
    self.appDelegate =[[UIApplication sharedApplication] delegate];
    self.appDelegate.locationManager = [[CLLocationManager alloc] init];
    self.appDelegate.locationManager.delegate = self;
    [ self.appDelegate.locationManager startMonitoringSignificantLocationChanges];
    
    //sets the accuracy to within 100 meters
    self.appDelegate.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //call update only when horizontal distance reaches 1000m
    self.appDelegate.locationManager.distanceFilter = 1000;
    
    CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:[self.note.latitude doubleValue] longitude:[self.note.longitude doubleValue]];
    
    [self addPinToMapAtLocation:currentLoc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changedName:(id)sender {
    self.note.title = self.nameField.text;
    self.note.text = self.describe.text;
    
    [self.appDelegate.managedObjectContext save:nil];
 
}

#pragma mark - CLLocationManagerDelegate methods
/*
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"lat: %f, lon:%f", location.coordinate.latitude, location.coordinate.longitude);
    [self addPinToMapAtLocation:location];
    
}*/

- (void)addPinToMapAtLocation:(CLLocation *)location
{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = location.coordinate;
    pin.title = @"Location";
    pin.subtitle = @"Note Made Here";
    [self.mapView addAnnotation:pin];
    [self focusOnPoint:location];
}

- (void) focusOnPoint:(CLLocation*) location
{
    CLLocationCoordinate2D here =  location.coordinate;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=10;
    span.longitudeDelta=10;
    region.span=span;
    region.center=here;
    [self.mapView setRegion:region animated:TRUE];
    [self.mapView regionThatFits:region];
}
@end

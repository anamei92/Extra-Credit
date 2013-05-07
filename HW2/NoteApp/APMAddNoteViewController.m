//
//  APMAddNoteViewController.m
//  NoteApp
//
//  Created by Ana Mei on 3/15/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import "APMAddNoteViewController.h"
#import "APMTableMainController.h"
#import "SaveNote.h"
#import "APmAppDelegate.h"


@interface APMAddNoteViewController ()

@end

@implementation APMAddNoteViewController

APMAppDelegate *appDelegate;
@synthesize nameField = _nameField;
@synthesize descriptionView = _descriptionView;
@synthesize mainNotesController = _mainNotesController;
@synthesize locationManager = _locationManager;

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedDone:(id)sender {
    
    //Add the object into core data
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    if(self.nameField.text.length <= 0 || self.descriptionView.text.length <= 0){
        NSLog(@"Not Added");
    }
    else{
        SaveNote *newSaveNote = [NSEntityDescription insertNewObjectForEntityForName:@"SaveNote" inManagedObjectContext: context];
    
    
        newSaveNote.title = self.nameField.text;
        newSaveNote.text = self.descriptionView.text;
        newSaveNote.latitude = [NSNumber numberWithDouble: self.locationManager.location.coordinate.latitude];
        newSaveNote.longitude = [NSNumber numberWithDouble: self.locationManager.location.coordinate.longitude];
    
        NSError *error;
    
    if(![context save:&error]){
        NSLog(@"Error");
        }
    }
    /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SaveNote"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *current in fetchedObjects){
        NSLog(@"Name : %@", [current valueForKey:@"title"]);
        NSLog(@"Description: %@", [ current valueForKey:@"text"]);
    }*/
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
    //[self.mainNotesController.tableView reloadData];

- (IBAction)pressedCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

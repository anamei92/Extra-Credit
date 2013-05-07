//
//  APMViewController.m
//  FBLogin
//
//  Created by Ana Mei on 5/5/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import "APMViewController.h"

@interface APMViewController ()

@end

@implementation APMViewController

@synthesize myImg = _myImhg;
@synthesize myStatus = _myStatus;
@synthesize activity = _activity;
@synthesize UploadPhoto  = _UploadPhoto;
@synthesize UpdateStatus = _UpdateStatus;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fb_bg.png"]];
    self.displayImages = [[NSArray alloc] initWithObjects:@"meme1.jpg",@"meme2.jpg",@"meme3.jpg",@"meme4.jpg",@"meme5.jpg" , nil];
    
    int imagesIndex = ((int)random() % (5));
    
    [self.myImg setImage:[UIImage imageNamed:[self.displayImages objectAtIndex:imagesIndex]]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)controlStatusUsable:(BOOL)usable {
    if (usable) {
        self.UploadPhoto.userInteractionEnabled = YES;
        self.UpdateStatus.userInteractionEnabled = YES;
        self.activity.hidden = YES;
        [self.activity stopAnimating];
    } else {
        self.UploadPhoto.userInteractionEnabled = NO;
        self.UpdateStatus.userInteractionEnabled = NO;
        self.activity.hidden = NO;
        [self.activity startAnimating];
    }
    
}

-(void)ForUploadPhoto {
    [self controlStatusUsable:NO];
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
         if (!error) {
             
             UIAlertView *tmp = [[UIAlertView alloc]
                                 initWithTitle:@"Upload to Facebook?"
                                 message:[NSString stringWithFormat:@"Upload to ""%@"" Account?", user.name]
                                 delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"No",@"Yes", nil];
             tmp.tag = 200; // to upload
             [tmp show];
             
         }
         
         [self controlStatusUsable:YES];
     }];
}


-(void) ForStatusUpdate {
    [self controlStatusUsable:NO];
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
         if (!error) {
             
             UIAlertView *tmp = [[UIAlertView alloc]
                                 initWithTitle:@"Publish to FB?"
                                 message:[NSString stringWithFormat:@"Publish status to ""%@"" Account?", user.name]
                                 delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"No",@"Yes", nil];
             tmp.tag = 300; // to update status
             [tmp show];
             
         }
         
         [self controlStatusUsable:YES];
     }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==1) { // yes answer
        if (alertView.tag==200) {
            // then upload
            [self controlStatusUsable:NO];
            [FBRequestConnection startForUploadPhoto:self.myImg.image
                                   completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                       if (!error) {
                                           UIAlertView *alertPhoto = [[UIAlertView alloc]
                                                               initWithTitle:@"Success"
                                                               message:@"Photo Uploaded"
                                                               delegate:self
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:@"Ok", nil];
                                           
                                           [alertPhoto show];
                                       } else {
                                           UIAlertView *alertPhoto = [[UIAlertView alloc]
                                                               initWithTitle:@"Error"
                                                               message:@"Please check your login information. Something went wrong in connecting to Facebook."
                                                               delegate:self
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:@"Ok", nil];
                                           
                                           [alertPhoto show];
                                       }
                                       
                                       [self controlStatusUsable:YES];
                                   }];
            
        }
        
        if (alertView.tag==300) { // this tag means that the user is trying to post status
            
            [FBRequestConnection startForPostStatusUpdate:self.myStatus.text completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    UIAlertView *tmp = [[UIAlertView alloc]
                                        initWithTitle:@"Success"
                                        message:@"Status Posted"
                                        delegate:self
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"Ok", nil];
                    
                    [tmp show];
                    
                } else {
                    UIAlertView *tmp = [[UIAlertView alloc]
                                        initWithTitle:@"Error"
                                        message:@"Please check your login information. Something went wrong in connecting to Facebook."
                                        delegate:self
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"Ok", nil];
                    
                    [tmp show];
                   
                }
            }];
        }
        
    }
    
}


-(IBAction)uploadPhoto:(id)sender {
    
    if (FBSession.activeSession.isOpen) {
        
        // Yes, we are open, so lets make a request for user details so we can get the user name.
        
        [self ForUploadPhoto];
        
        
        
    } else {
        
        // We don't have an active session in this app, so lets open a new
        // facebook session with the appropriate permissions!
        
        // Firstly, construct a permission array.
        // you can find more "permissions strings" at http://developers.facebook.com/docs/authentication/permissions/
        // In this example, we will just request a publish_stream which is required to publish status or photos.
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"publish_stream",
                                nil];
        [self controlStatusUsable:NO];
        // OPEN Session!
        [FBSession openActiveSessionWithPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      // show error message if login fails
                                      if (error) {
                                          
                                        //user sees the error
                                          
                                      } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                          
                                          // no error, so we proceed with requesting user details of current facebook session.
                                          
                                          [self ForUploadPhoto];
                                      }
                                      [self controlStatusUsable:YES];
                                  }];
    }
}


-(IBAction)updateStatus:(id)sender {
    if (FBSession.activeSession.isOpen) {
        
        
        [self ForStatusUpdate];
        
        
    } else {
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"publish_stream",
                                nil];
        [self controlStatusUsable:NO];
        [FBSession openActiveSessionWithPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      // if login fails for any reason, we alert
                                      if (error) {
                                          
                                          
                                      } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                          
                                          [[FBRequest requestForMe] startWithCompletionHandler:
                                           ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                                               if (!error) {
                                                   [self ForStatusUpdate];
                                                   
                                               }
                                               [self controlStatusUsable:YES];
                                           }];
                                      }
                                  }];
    }
    
}

- (IBAction) completeEdit:(id) sender{
    [self.view endEditing:true];
}

- (IBAction)randomPhoto:(id)sender {
    
    int imagesIndex = ((int)random() % (5));
    
    [self.myImg setImage:[UIImage imageNamed:[self.displayImages objectAtIndex:imagesIndex]]];
    
}
@end

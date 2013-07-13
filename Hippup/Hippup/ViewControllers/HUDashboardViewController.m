//
//  HUDashboardViewController.m
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUDashboardViewController.h"
#import <Parse/Parse.h>
#import "BodilyFunctionManager.h"

@interface HUDashboardViewController ()
-(void)saveHiccupAtLocation:(CLLocation*)location;
@end

@implementation HUDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BodilyFunctionManager * bfm = [[BodilyFunctionManager alloc] init];
    [bfm myBodilyFunctions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)hiccupPressed:(id)sender
{
    if(_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    _btnHiccup.enabled = NO;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    [manager stopUpdatingLocation];
    BodilyFunctionModel * newBF = [[BodilyFunctionModel alloc] initWithType:bodilyFunctionTypeHiccup
                                                                  timestamp:[[NSDate date] timeIntervalSince1970]
                                                                   latitude:newLocation.coordinate.latitude
                                                                  longitude:newLocation.coordinate.longitude
         
                                                                   username:[PFUser currentUser].username];
    
    [newBF saveItWithSuccessBlock:^(BOOL succeeded, NSError *error) {
        _btnHiccup.enabled = YES;
        [[BodilyFunctionManager getInstance] saveBodilyFunction:newBF];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    _btnHiccup.enabled = YES;
	NSLog(@"Error: %@", [error description]);
}

@end

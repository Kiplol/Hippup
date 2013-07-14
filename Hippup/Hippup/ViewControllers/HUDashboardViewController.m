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
#import "HUSessionData.h"

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
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialLoad
{
    HUSessionData * data = [HUSessionData getInstance];
    data.myBFs = [NSMutableArray arrayWithArray: [[BodilyFunctionManager getInstance] bodilyFunctionsForUser:data.username]];
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

#pragma mark - Location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    [manager stopUpdatingLocation];
    BodilyFunctionModel * newBF = [[BodilyFunctionModel alloc] initWithType:bodilyFunctionTypeHiccup
                                                                  timestamp:[[NSDate date] timeIntervalSince1970]
                                                                   latitude:newLocation.coordinate.latitude
                                                                  longitude:newLocation.coordinate.longitude
         
                                                                   username:[PFUser currentUser].username];
    
    [newBF saveToParseWithSuccessBlock:^(BOOL succeeded, NSError *error) {
        _btnHiccup.enabled = YES;
        [[HUSessionData getInstance].myBFs addObject:newBF];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    _btnHiccup.enabled = YES;
	NSLog(@"Error: %@", [error description]);
}

@end

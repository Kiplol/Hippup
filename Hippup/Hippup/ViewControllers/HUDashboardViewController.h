//
//  HUDashboardViewController.h
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BodilyFunctionModel.h"

@interface HUDashboardViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet UIButton * _btnHiccup;
    IBOutlet UIButton * _btnMap;
    CLLocationManager * _locationManager;
}

-(IBAction)hiccupPressed:(id)sender;
-(void)initialLoad;
@end

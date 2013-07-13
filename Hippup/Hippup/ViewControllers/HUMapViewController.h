//
//  HUMapViewController.h
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HUMapViewController : UIViewController {
    IBOutlet MKMapView * _mapView;
    NSMutableArray * _arrBodilyFunctions;
    double _minLat, _minLong, _maxLat, _maxLong;
    CLLocationManager * _locationManager;
}

@end

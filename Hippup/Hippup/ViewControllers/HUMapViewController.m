//
//  HUMapViewController.m
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUMapViewController.h"
#import <Parse/Parse.h>
#import "BodilyFunctionModel.h"
#import "BodilyFunctionManager.h"
#import <CoreLocation/CoreLocation.h>

@interface HUMapViewController () <CLLocationManagerDelegate>
-(void)repositionMap;
-(void)dropPins;
-(void)clearPins;
-(IBAction)backPressed;
@end

@implementation HUMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arrOthersBodilyFunctions = [[NSMutableArray alloc] init];
        _arrMyBodilyFunctions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _arrOthersBodilyFunctions = [[NSMutableArray alloc] init];
        _arrMyBodilyFunctions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self reloadBFData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self centerMapOnMe];
}

-(void)centerMapOnMe
{
    if(_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    [_locationManager startUpdatingLocation];
}
-(void)reloadBFData
{
    [_arrOthersBodilyFunctions removeAllObjects];
    _arrMyBodilyFunctions = [[BodilyFunctionManager getInstance] bodilyFunctionsForUser:[PFUser currentUser].username];
    _minLat = _minLong = INT_MAX;
    _maxLat = _maxLong = INT_MIN;
    
    double past24Hours = [[NSDate date] timeIntervalSince1970] - (60 * 60 * 24);
    
    PFQuery *query = [PFQuery queryWithClassName:@"BodilyFunction"];
    [query whereKey:KEY_USERNAME notEqualTo:[PFUser currentUser].username];
    [query whereKey:KEY_TIMESTAMP greaterThan:[NSNumber numberWithDouble:past24Hours]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *bfs, NSError *error) {
        if(bfs.count)
        {
            for(NSDictionary * bfData in bfs)
            {
                BodilyFunctionModel * bf = [[BodilyFunctionModel alloc] initWithData:bfData];
                if(bf.latitude > _maxLat)
                    _maxLat = bf.latitude;
                if(bf.latitude < _minLat)
                    _minLat = bf.latitude;
                if(bf.longitude > _maxLong)
                    _maxLong = bf.longitude;
                if(bf.longitude < _minLong)
                    _minLong = bf.longitude;
                [_arrOthersBodilyFunctions addObject:bf];
            }
            [self dropPins];
        }
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    [manager stopUpdatingLocation];
    MKCoordinateRegion region;
    region.center = newLocation.coordinate;
    region.span = MKCoordinateSpanMake(.005, .005);
    [_mapView setRegion:region animated:YES];
    [_mapView regionThatFits:region];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

-(void)repositionMap
{
    double latDelta = _maxLat - _minLat;
    double longDelta = _maxLong - _minLong;
    MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, longDelta);
    MKCoordinateRegion region;
    region.span = span;
    region.center = CLLocationCoordinate2DMake(_maxLat - (latDelta * 0.5f), _maxLong - (longDelta * 0.5f));
    [_mapView setRegion:region animated:YES];
    [_mapView regionThatFits:region];
}
-(void)dropPins
{
    [self clearPins];
    for(BodilyFunctionModel * bf in _arrOthersBodilyFunctions)
    {
        [_mapView addAnnotation:bf];
    }
    for(BodilyFunctionModel * bf in _arrMyBodilyFunctions)
    {
        [_mapView addAnnotation:bf];
    }
}

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    // reuse a view, if one exists
    MKAnnotationView *aView;
    if([annotation isKindOfClass:[BodilyFunctionModel class]])
    {
        BodilyFunctionModel * bf = (BodilyFunctionModel*)annotation;
        BOOL isMe = [bf.username isEqualToString:[PFUser currentUser].username];
        if(isMe)
        {
            aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"me"];
            if (!aView)
            {
                aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"me"];
                aView.image = [UIImage imageNamed:@"pinRed.png"];
            }
            
        }
        else
        {
            aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"others"];
            if (!aView)
            {
                aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"others"];
                aView.image = [UIImage imageNamed:@"pinPurple.png"];
            }
        }
    }
    return aView;
}
-(void)clearPins
{
    
}
-(IBAction)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

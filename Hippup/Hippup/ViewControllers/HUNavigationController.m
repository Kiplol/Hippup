//
//  HUNavigationController.m
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUNavigationController.h"
#import "HUSegmentNavView.h"

@interface HUNavigationController ()
-(void)mapTapped;
-(void)dashTapped;
-(void)infoTapped;
@end

@implementation HUNavigationController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
        _dashVC = [storyboard instantiateViewControllerWithIdentifier:@"Dash"];
        _mapVC = [storyboard instantiateViewControllerWithIdentifier:@"Map"];
        [self addChildViewController:_mapVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViewControllers:[NSArray arrayWithObject:_dashVC]];
	HUSegmentNavView * husnv = [[[NSBundle mainBundle] loadNibNamed:@"HUSegmentNavView" owner:nil options:nil] objectAtIndex:0];
    husnv.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    husnv.center = CGPointMake(self.view.frame.size.width * 0.5f, self.view.frame.size.height - husnv.frame.size.height - 15.0);
    [self.view addSubview:husnv];
    
    [husnv.btnInfo addTarget:self action:@selector(infoTapped) forControlEvents:UIControlEventTouchUpInside];
    [husnv.btnDashboard addTarget:self action:@selector(dashTapped) forControlEvents:UIControlEventTouchUpInside];
    [husnv.btnMap addTarget:self action:@selector(mapTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapTapped
{
    [self setViewControllers:[NSArray arrayWithObject:_mapVC] animated:YES];
    [_mapVC reloadBFData];
}
-(void)dashTapped
{
    [self setViewControllers:[NSArray arrayWithObject:_dashVC] animated:YES];
}
-(void)infoTapped
{
    
}

@end

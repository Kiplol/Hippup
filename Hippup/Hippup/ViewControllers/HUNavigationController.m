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
        _containerVC = [[UIViewController alloc] init];
        [_containerVC addChildViewController:_dashVC];
        [_containerVC addChildViewController:_mapVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViewControllers:[NSArray arrayWithObject:_containerVC]];
    _dashVC.view.frame = _containerVC.view.bounds;
    [_containerVC.view addSubview:_dashVC.view];
    _currentVC = _dashVC;
    
    UIImageView * bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]];
    [self.view addSubview:bg];
    [self.view sendSubviewToBack:bg];
    
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
    if(_mapVC == _currentVC)
        return;
    UIViewController * lastVC = _currentVC;
    _currentVC = _mapVC;
    
    _mapVC.view.center = CGPointMake(_containerVC.view.bounds.size.width +  _mapVC.view.bounds.size.width * 0.5, _mapVC.view.center.y);
    [_containerVC transitionFromViewController:lastVC
                              toViewController:_currentVC
                                      duration:0.5
                                       options:UIViewAnimationOptionBeginFromCurrentState
                                    animations:^{
                                        lastVC.view.center = CGPointMake(0 - lastVC.view.bounds.size.width * 0.5, lastVC.view.center.y);
                                        _currentVC.view.center = CGPointMake(_containerVC.view.bounds.size.width * 0.5,
                                                                             _containerVC.view.bounds.size.height * 0.5);
                                        //animations
                                    } completion:^(BOOL finished) {
                                        //completion
                                        [_currentVC didMoveToParentViewController:_containerVC];
                                        [_mapVC reloadBFData];
                                    }];
}
-(void)dashTapped
{
    if(_dashVC == _currentVC)
        return;
    UIViewController * lastVC = _currentVC;
    _currentVC = _dashVC;
    
    BOOL moveLeft = (lastVC == _mapVC);
    if(moveLeft)
    {
        _dashVC.view.center = CGPointMake(0 - _mapVC.view.bounds.size.width * 0.5, _mapVC.view.center.y);
    }
    else
    {
       _dashVC.view.center = CGPointMake(_containerVC.view.bounds.size.width + _mapVC.view.bounds.size.width * 0.5, _mapVC.view.center.y);
    }
    
    [_containerVC transitionFromViewController:lastVC
                              toViewController:_currentVC
                                      duration:0.5
                                       options:UIViewAnimationOptionBeginFromCurrentState
                                    animations:^{
                                        if(moveLeft)
                                        {
                                            lastVC.view.center = CGPointMake(_containerVC.view.bounds.size.width + lastVC.view.bounds.size.width * 0.5, lastVC.view.center.y);
                                        }
                                        else
                                        {
                                            lastVC.view.center = CGPointMake(0 - lastVC.view.bounds.size.width * 0.5, lastVC.view.center.y);
                                        }
                                        _currentVC.view.center = CGPointMake(_containerVC.view.bounds.size.width * 0.5,
                                                                             _containerVC.view.bounds.size.height * 0.5);
                                        //animations
                                    } completion:^(BOOL finished) {
                                        //completion
                                        [_currentVC didMoveToParentViewController:_containerVC];
                                    }];
}
-(void)infoTapped
{
    
}
@end

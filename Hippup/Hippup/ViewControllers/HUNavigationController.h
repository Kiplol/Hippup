//
//  HUNavigationController.h
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUDashboardViewController.h"
#import "HUMapViewController.h"
#import  "HUInfoViewController.h"

@interface HUNavigationController : UINavigationController {
    HUMapViewController * _mapVC;
    HUDashboardViewController * _dashVC;
    HUInfoViewController * _infoVC;
    UIViewController * _containerVC;
    UIViewController * _currentVC;
}

@end

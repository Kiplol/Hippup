//
//  HUSegmentNav.h
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUSegmentNavView : UIView {
    IBOutlet UIButton * _btnDashboard;
    IBOutlet UIButton * _btnMap;
    IBOutlet UIButton * _btnInfo;
}

@property (nonatomic, readonly) UIButton * btnDashboard;
@property (nonatomic, readonly) UIButton * btnMap;
@property (nonatomic, readonly) UIButton * btnInfo;

-(void)selectNavButton:(UIButton*)btn;

@end

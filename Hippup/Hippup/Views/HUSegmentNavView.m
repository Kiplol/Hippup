//
//  HUSegmentNav.m
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUSegmentNavView.h"

@implementation HUSegmentNavView
@synthesize btnDashboard = _btnDashboard;
@synthesize btnMap = _btnMap;
@synthesize btnInfo = _btnInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [_btnDashboard addTarget:self action:@selector(selectNavButton:) forControlEvents:UIControlEventTouchUpInside];
    [_btnInfo addTarget:self action:@selector(selectNavButton:) forControlEvents:UIControlEventTouchUpInside];
    [_btnMap addTarget:self action:@selector(selectNavButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectNavButton:(UIButton *)btn
{
    if(btn.selected)
        return;
    _btnMap.selected = NO;
    _btnInfo.selected = NO;
    _btnDashboard.selected = NO;
    btn.selected = YES;
}
@end

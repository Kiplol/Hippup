//
//  HUInfoCell.m
//  Hippup
//
//  Created by Elliott Kipper on 7/14/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUInfoCell.h"

@implementation HUInfoCell
@synthesize keyLabel = _lblKey;
@synthesize valueLabel = _lblValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

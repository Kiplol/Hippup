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

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_lblKey sizeToFit];
    CGFloat maxValWidth = self.bounds.size.width - (CGRectGetMaxX(_lblKey.frame) + 10.0f);
    [_lblValue sizeToFit];
    if(_lblValue.bounds.size.width > maxValWidth)
    {
        _lblValue.frame = CGRectMake(CGRectGetMaxX(_lblKey.frame) + 5.0f, _lblValue.frame.origin.y, maxValWidth, _lblValue.frame.size.height);
    }
    else
    {
        _lblValue.frame = CGRectMake(self.bounds.size.width - 5.0f - _lblValue.bounds.size.width, _lblValue.frame.origin.y, _lblValue.bounds.size.width, _lblValue.bounds.size.height);
    }
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

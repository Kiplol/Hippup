//
//  HUSessionData.m
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUSessionData.h"

@implementation HUSessionData
@synthesize username = _szUsername;
@synthesize myBFs = _arrMyBFs;

+(HUSessionData*)getInstance
{
    static dispatch_once_t once;
    static HUSessionData * pInstance;
    
    dispatch_once(&once, ^{
        pInstance = [[HUSessionData alloc] init];
    });
    
    return pInstance;
}
@end

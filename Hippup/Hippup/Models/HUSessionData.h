//
//  HUSessionData.h
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUSessionData : NSObject {
    NSMutableArray * _arrMyBFs;
    NSString * _szUsername;
}

@property (nonatomic, retain) NSMutableArray * myBFs;
@property (nonatomic, retain) NSString * username;

+(HUSessionData*)getInstance;

@end

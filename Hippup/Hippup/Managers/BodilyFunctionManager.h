//
//  BodilyFunctionManager.h
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BodilyFunctionModel.h"

@interface BodilyFunctionManager : NSObject {
    
}

+(BodilyFunctionManager*)getInstance;
-(NSArray*)bodilyFunctionsForUser:(NSString*)username;
-(NSArray*)bodilyFunctionsForUser:(NSString*)username since:(double)timestamp;
@end

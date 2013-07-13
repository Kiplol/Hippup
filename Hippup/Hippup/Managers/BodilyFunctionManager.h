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
-(void)saveBodilyFunction:(BodilyFunctionModel*)bf;
-(NSArray*)myBodilyFunctions;
@end

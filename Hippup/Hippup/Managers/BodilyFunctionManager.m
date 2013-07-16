//
//  BodilyFunctionManager.m
//  Hippup
//
//  Created by Elliott Kipper on 7/13/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "BodilyFunctionManager.h"
#import "HUAppDelegate.h"

@implementation BodilyFunctionManager

+(BodilyFunctionManager*)getInstance
{
    static dispatch_once_t once;
    static BodilyFunctionManager * pInstance;
    
    dispatch_once(&once, ^{
        pInstance = [[BodilyFunctionManager alloc] init];
    });
    
    return pInstance;
}

-(NSArray*)bodilyFunctionsForUser:(NSString*)username
{
    return [self bodilyFunctionsForUser:username since:0];
}
-(NSArray*)bodilyFunctionsForUser:(NSString*)username since:(double)timestamp
{
    HUAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"BodilyFunctionModel"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    [request setReturnsObjectsAsFaults:NO];  //Is there a way to get around doing this?
    
    NSPredicate * usernamePred = [NSPredicate predicateWithFormat:@"(username = %@)", username];
    NSPredicate * timestampPred = [NSPredicate predicateWithFormat:@"(timestamp >= %f)", timestamp];
    if(username && timestamp > 0)
    {
        NSPredicate * compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[usernamePred, timestampPred]];
        [request setPredicate:compoundPredicate];
    }
    else if(username)
    {
        [request setPredicate:usernamePred];
    }
    else if(timestamp > 0)
    {
        [request setPredicate:timestampPred];
    }
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        return nil;
    } else {
        return objects;
    }
}
@end

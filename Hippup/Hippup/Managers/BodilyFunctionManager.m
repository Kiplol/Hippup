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
-(void)saveBodilyFunction:(BodilyFunctionModel*)bf
{
    HUAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newBF;
    newBF = [NSEntityDescription
                  insertNewObjectForEntityForName:@"BodilyFunctionModel"
                  inManagedObjectContext:context];
    [newBF setValue:[NSNumber numberWithDouble:bf.timestamp] forKey:KEY_TIMESTAMP];
    [newBF setValue:[NSNumber numberWithDouble:bf.latitude] forKey:KEY_LATITUDE];
    [newBF setValue:[NSNumber numberWithDouble:bf.longitude] forKey:KEY_LONGITUDE];
    [newBF setValue:bf.username forKey:KEY_USERNAME];
    [newBF setValue:[NSNumber numberWithInt:bf.type] forKey:KEY_BODILY_FUNCTION_TYPE];
    
    NSError *error;
    [context save:&error];
}

-(NSArray*)myBodilyFunctions
{
    HUAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"BodilyFunctionModel"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(username = %@)", [PFUser currentUser].username];
    [request setPredicate:pred];
    
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

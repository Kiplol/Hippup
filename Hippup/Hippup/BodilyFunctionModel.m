//
//  BodilyFunctionModel.m
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "BodilyFunctionModel.h"
#import <Parse/Parse.h>
#import "HUAppDelegate.h"

@implementation BodilyFunctionModel
@synthesize latitude;
@synthesize longitude;
@synthesize type;
@synthesize username;
@synthesize timestamp;

-(id)initWithType:(bodilyFunctionType)aType timestamp:(double)aTimestamp latitude:(double)aLatitude longitude:(double)aLongitude username:(NSString *)aUsername
{
    HUAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BodilyFunctionModel" inManagedObjectContext:context];
    self = [self initWithEntity:entity insertIntoManagedObjectContext:nil];
    if (self != nil) {
        self.timestamp = aTimestamp;
        self.latitude = aLatitude;
        self.longitude = aLongitude;
        self.username = aUsername;
        self.type = aType;
        if (context != nil)
            [context insertObject:self];
    }
    return self;
}

-(id)initWithData:(NSDictionary*)data
{
        NSString * szType = [data objectForKey:KEY_BODILY_FUNCTION_TYPE];
        NSNumber * numTimestamp = [data objectForKey:KEY_TIMESTAMP];
        NSNumber * numLat = [data objectForKey:KEY_LATITUDE];
        NSNumber * numLong = [data objectForKey:KEY_LONGITUDE];
        NSString * username = [data objectForKey:KEY_USERNAME];
        
        bodilyFunctionType type = [BodilyFunctionModel typeForString:szType];
        NSAssert(numTimestamp, @"timestamp must not be nil");
        double timestamp = [numTimestamp doubleValue];
        NSAssert(numLat, @"latitude must not be nil");
        double latitude = [numLat doubleValue];
        NSAssert(numLong, @"longitude must not be nil");
        double longitude = [numLong doubleValue];
        NSAssert(username, @"username must not be nil");
        return [self initWithType:type
                      timestamp:timestamp
                       latitude:latitude
                      longitude:longitude
                       username:username];
}

-(void)saveToParse
{
    [self saveToParseWithSuccessBlock:nil];
}

-(void)saveToParseWithSuccessBlock:(PFBooleanResultBlock)success
{
    PFObject *testObject = [PFObject objectWithClassName:@"BodilyFunction"];
    [testObject setObject:[BodilyFunctionModel stringForType:self.type] forKey:KEY_BODILY_FUNCTION_TYPE];
    [testObject setObject:[NSNumber numberWithDouble:self.timestamp] forKey:KEY_TIMESTAMP];
    [testObject setObject:[NSNumber numberWithDouble:self.latitude] forKey:KEY_LATITUDE];
    [testObject setObject:[NSNumber numberWithDouble:self.longitude] forKey:KEY_LONGITUDE];
    [testObject setObject:self.username forKey:KEY_USERNAME];
    [testObject saveInBackgroundWithBlock:success];
}

+(NSString*)stringForType:(bodilyFunctionType)type
{
    switch (type) {
        case bodilyFunctionTypeHiccup:
            return @"Hiccup";
            break;
            
        case bodilyFunctionTypeBurp:
            return @"Burp";
            break;
            
        case bodilyFunctionTypeFart:
            return @"Fart";
            break;
            
        default:
            return @"EMPTY THIS IS NOT GOOD";
            break;
    }
}

+(bodilyFunctionType)typeForString:(NSString*)szType
{
    NSString * lowerType = [szType lowercaseString];
    if([lowerType isEqualToString:@"hiccup"])
        return bodilyFunctionTypeHiccup;
    else if([lowerType isEqualToString:@"burp"])
        return bodilyFunctionTypeBurp;
    else if([lowerType isEqualToString:@"fart"])
        return bodilyFunctionTypeFart;
    else
    {
        NSAssert(0, @"That string is not a type.  You are stupid.");
        return bodilyFunctionTypeFart;
    }
}

//-(NSString*)description
//{
//    return [NSString stringWithFormat:@"%@\ntype=%@\ntimestamp=%f\nlatitude=%f\nlongitude=%f\nusername=%@", [super description],
//            [BodilyFunctionModel stringForType:_type], _timestamp,_latitude, _longitude, _username];
//}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}
@end

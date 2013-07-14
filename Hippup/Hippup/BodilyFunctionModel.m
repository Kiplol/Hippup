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
@synthesize type = _type;
@synthesize timestamp = _timestamp;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize username = _username;

-(id)initWithType:(bodilyFunctionType)type timestamp:(double)timestamp latitude:(double)latitude longitude:(double)longitude username:(NSString *)username
{
    HUAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BodilyFunctionModel" inManagedObjectContext:context];
    self = [self initWithEntity:entity insertIntoManagedObjectContext:nil];
    if (self != nil) {
        [self setPrimitiveValue:[NSNumber numberWithDouble:timestamp] forKey:KEY_TIMESTAMP];
        [self setPrimitiveValue:[NSNumber numberWithDouble:longitude] forKey:KEY_LONGITUDE];
        [self setPrimitiveValue:[NSNumber numberWithDouble:latitude] forKey:KEY_LATITUDE];
        [self setPrimitiveValue:username forKey:KEY_USERNAME];
        _timestamp = timestamp;
        _latitude = latitude;
        _longitude = longitude;
        _username = username;
        _type = type;
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
    [testObject setObject:[BodilyFunctionModel stringForType:_type] forKey:KEY_BODILY_FUNCTION_TYPE];
    [testObject setObject:[NSNumber numberWithDouble:_timestamp] forKey:KEY_TIMESTAMP];
    [testObject setObject:[NSNumber numberWithDouble:_latitude] forKey:KEY_LATITUDE];
    [testObject setObject:[NSNumber numberWithDouble:_longitude] forKey:KEY_LONGITUDE];
    [testObject setObject:_username forKey:KEY_USERNAME];
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
    return CLLocationCoordinate2DMake(_latitude, _longitude);
}
@end

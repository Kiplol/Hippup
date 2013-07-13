//
//  BodilyFunctionModel.m
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "BodilyFunctionModel.h"
#import <Parse/Parse.h>

@implementation BodilyFunctionModel
@synthesize type = _type;
@synthesize timestamp = _timestamp;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize username = _username;

-(id)initWithType:(bodilyFunctionType)type timestamp:(double)timestamp latitude:(double)latitude longitude:(double)longitude username:(NSString *)username
{
    if((self = [super init]))
    {
        _type = type;
        _timestamp = timestamp;
        _latitude = latitude;
        _longitude = longitude;
        _username = username;
    }
    return self;
}

-(id)initWithData:(NSDictionary*)data
{
    if((self = [super init]))
    {
        NSString * szType = [data objectForKey:KEY_BODILY_FUNCTION_TYPE];
        NSNumber * numTimestamp = [data objectForKey:KEY_TIMESTAMP];
        NSNumber * numLat = [data objectForKey:KEY_LATITUDE];
        NSNumber * numLong = [data objectForKey:KEY_LONGITUDE];
        NSString * username = [data objectForKey:KEY_USERNAME];
        
        _type = [BodilyFunctionModel typeForString:szType];
        NSAssert(numTimestamp, @"timestamp must not be nil");
        _timestamp = [numTimestamp doubleValue];
        NSAssert(numLat, @"latitude must not be nil");
        _latitude = [numLat doubleValue];
        NSAssert(numLong, @"longitude must not be nil");
        _longitude = [numLong doubleValue];
        NSAssert(username, @"username must not be nil");
        _username = username;
    }
    return self;
}

-(void)saveIt
{
    [self saveItWithSuccessBlock:nil];
}

-(void)saveItWithSuccessBlock:(PFBooleanResultBlock)success
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

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@\ntype=%@\ntimestamp=%f\nlatitude=%f\nlongitude=%f\nusername=%@", [super description],
            [BodilyFunctionModel stringForType:_type], _timestamp,_latitude, _longitude, _username];
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(_latitude, _longitude);
}
@end

//
//  BodilyFunctionModel.h
//  Hippup
//
//  Created by Elliott Kipper on 7/12/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

#define KEY_BODILY_FUNCTION_TYPE @"type"
#define KEY_TIMESTAMP @"timestamp"
#define KEY_LATITUDE @"latitude"
#define KEY_LONGITUDE @"longitude"
#define KEY_USERNAME @"username"

typedef enum {bodilyFunctionTypeHiccup = 0, bodilyFunctionTypeFart, bodilyFunctionTypeBurp} bodilyFunctionType;
@interface BodilyFunctionModel : NSManagedObject <MKAnnotation> {
    bodilyFunctionType _type;
    double _timestamp;
    double _latitude;
    double _longitude;
    NSString * _username;
}

@property (nonatomic, readwrite) bodilyFunctionType type;
@property (nonatomic, readwrite) double timestamp;
@property (nonatomic, readwrite) double latitude;
@property (nonatomic, readwrite) double longitude;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithType:(bodilyFunctionType)type timestamp:(double)timestamp latitude:(double)latitude longitude:(double)longitude username:(NSString *)username;
-(id)initWithData:(NSDictionary*)data;
-(void)saveToParse;
-(void)saveToParseWithSuccessBlock:(PFBooleanResultBlock)success;
+(NSString*)stringForType:(bodilyFunctionType)type;
+(bodilyFunctionType)typeForString:(NSString*)szType;

@end

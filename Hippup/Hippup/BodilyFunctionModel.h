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

}

@property double latitude;
@property double longitude;
@property double timestamp;
@property int type;
@property (nonatomic, retain) NSString * username;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithType:(bodilyFunctionType)aType timestamp:(double)aTimestamp latitude:(double)aLatitude longitude:(double)aLongitude username:(NSString *)aUsername;
-(id)initWithData:(NSDictionary*)data;
-(void)saveToParse;
-(void)saveToParseWithSuccessBlock:(PFBooleanResultBlock)success;
+(NSString*)stringForType:(bodilyFunctionType)type;
+(bodilyFunctionType)typeForString:(NSString*)szType;

@end

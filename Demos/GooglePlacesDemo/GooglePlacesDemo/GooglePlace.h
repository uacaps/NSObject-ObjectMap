//
//  GooglePlace.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleGeometry.h"
#import "GoogleOpeningHours.h"
#import "NSObject+ObjectMap.h"

@interface GooglePlace : NSObject
@property (nonatomic, retain) NSString *formatted_address;
@property (nonatomic, retain) GoogleGeometry *geometry;
@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSNumber *price_level;
@property (nonatomic, retain) NSString *reference;
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) NSString *vicinity;
@property (nonatomic, retain) NSArray *photos;
@property (nonatomic, retain) GoogleOpeningHours *opening_hours;

-(NSMutableString *)typesString;
@end

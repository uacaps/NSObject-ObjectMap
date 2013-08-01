//
//  GooglePlaceDetails.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePlace.h"
#import "NSObject+ObjectMap.h"

@interface GooglePlaceDetails : GooglePlace
@property (nonatomic, retain) NSArray *address_components;
@property (nonatomic, retain) NSString *formatted_address;
@property (nonatomic, retain) NSString *formatted_phone_number;
@property (nonatomic, retain) NSArray *reviews;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSNumber *utc_offset;

@end

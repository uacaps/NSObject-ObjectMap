//
//  GooglePlaceDetails.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePlaceDetails.h"

@implementation GooglePlaceDetails

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"GoogleAddressComponent" forKeyPath:@"propertyArrayMap.address_components"];
        [self setValue:@"GoogleReview" forKeyPath:@"propertyArrayMap.reviews"];
    }
    return self;
}

@end

//
//  GooglePlacesResponse.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePlacesResponse.h"

@implementation GooglePlacesResponse

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"NSString" forKeyPath:@"propertyArrayMap.html_attributions"];
        [self setValue:@"GooglePlace" forKeyPath:@"propertyArrayMap.results"];
    }
    return self;
}

@end

//
//  GoogleAddressComponent.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GoogleAddressComponent.h"

@implementation GoogleAddressComponent

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"NSString" forKeyPath:@"propertyArrayMap.types"];
    }
    return self;
}

@end

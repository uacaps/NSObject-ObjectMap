//
//  GooglePhoto.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePhoto.h"

@implementation GooglePhoto

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"NSString" forKeyPath:@"propertyArrayMap.html_attributions"];
    }
    return self;
}

@end

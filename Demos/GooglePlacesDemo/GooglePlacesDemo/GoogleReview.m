//
//  GoogleReview.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GoogleReview.h"

@implementation GoogleReview

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"GoogleReviewAspect" forKeyPath:@"propertyArrayMap.aspects"];
    }
    return self;
}

@end

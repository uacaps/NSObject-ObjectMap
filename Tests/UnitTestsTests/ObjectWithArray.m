//
//  ObjectWithArray.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "ObjectWithArray.h"

@implementation ObjectWithArray

- (instancetype)init {
    if (self = [super init]) {
        [self setValue:@"SingleObject" forKeyPath:@"propertyArrayMap.arrayOfObjects"];
    }
    
    return self;
}

@end

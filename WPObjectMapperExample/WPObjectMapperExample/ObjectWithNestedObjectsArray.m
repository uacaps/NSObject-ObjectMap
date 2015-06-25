//
//  ObjectWithNestedObjectsArray.m
//  UnitTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "ObjectWithNestedObjectsArray.h"
#import "NestedObject.h"

@implementation ObjectWithNestedObjectsArray

- (instancetype)init{
    if (self = [super init]) {
        // Set Property Type
        [self setValue:@"NestedObject" forKeyPath:@"propertyArrayMap.arrayOfObjects"];
    }
    
    return self;
}

+ (ObjectWithNestedObjectsArray *)newObjectWithArrayOfNestedObjects {
    ObjectWithNestedObjectsArray *newObject = [[ObjectWithNestedObjectsArray alloc] init];
    newObject.arrayOfObjects = @[[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject]];
    return newObject;
}

@end

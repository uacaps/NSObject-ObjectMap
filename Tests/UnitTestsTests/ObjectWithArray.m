//
//  ObjectWithArray.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "ObjectWithArray.h"

@implementation ObjectWithArray

- (instancetype)initWithInsideObjectType:(InsideObjectType)type {
    if (self = [super init]) {
        // Set Property Type
        [self setValue:(type == InsideObjectTypeSingle ? @"SingleObject" : @"NestedObject") forKeyPath:@"propertyArrayMap.arrayOfObjects"];
    }
    
    return self;
}

+ (ObjectWithArray *)newObjectWithArrayOfSingleObjects {
    ObjectWithArray *newObject = [[ObjectWithArray alloc] initWithInsideObjectType:InsideObjectTypeSingle];
    newObject.arrayOfObjects = @[[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject]];
    return newObject;
}


+ (ObjectWithArray *)newObjectWithArrayOfNestedObjects {
    ObjectWithArray *newObject = [[ObjectWithArray alloc] initWithInsideObjectType:InsideObjectTypeNested];
    newObject.arrayOfObjects = @[[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject]];
    return newObject;
}

@end

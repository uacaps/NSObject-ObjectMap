//
//  NestedObject.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "NestedObject.h"

@implementation NestedObject

+ (NestedObject *)newNestedObject {
    NestedObject *newNestedObject = [[NestedObject alloc] init];
    newNestedObject.singleObject = [SingleObject newSingleObject];
    return newNestedObject;
}

@end

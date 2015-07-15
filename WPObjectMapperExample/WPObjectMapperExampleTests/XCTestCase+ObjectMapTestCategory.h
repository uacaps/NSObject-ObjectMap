//
//  XCTestCase+ObjectMapTestCategory.h
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+ObjectMap.h"


@interface XCTestCase (ObjectMapTestCategory)

// Testing Options
- (void)testEqualityOfObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(const char*)methodName dataType:(CAPSDataType)type;
- (void)testInequalityOfObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(const char*)methodName dataType:(CAPSDataType)type;

// Auxiliary Methods
- (NSString *)stringForType:(CAPSDataType)type;

@end

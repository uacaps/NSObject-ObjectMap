//
//  XCTestCase+ObjectMapTestCategory.h
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+ObjectMap.h"

typedef NS_ENUM(NSInteger, DataType) {
    DataTypeXML,
    DataTypeJSON,
    DataTypeSOAP
};


@interface XCTestCase (ObjectMapTestCategory)

- (void)testObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(NSString *)methodName dataType:(DataType)type;
- (NSString *)stringForType:(DataType)type;

@end

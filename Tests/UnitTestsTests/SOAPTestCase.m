//
//  SOAPTestCase.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+ObjectMap.h"
#import "SingleObject.h"
#import "NestedObject.h"
#import "ObjectWithArray.h"
#import "ObjectMapTestCase.m"

@interface SOAPTestCase : ObjectMapTestCase

@end

@implementation SOAPTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSingleObject
{
    //Create object to be serialized
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    testSingleObject.testString = @"This is a test";
    testSingleObject.testBoolean = @YES;
    testSingleObject.testNumber = @123;
    testSingleObject.testDate = [NSDate date];
    
    //Serialize object, then deserialize it back to an object
    SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromJSONData:[testSingleObject JSONData]];
    
    //Test all properties
    [self testObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:@"testSingleObject" dataType:DataTypeJSON];
}


- (void)testNestedObject {
    // Create single object
    SingleObject *newSingleObject = [[SingleObject alloc] init];
    newSingleObject.testString = @"Hello World";
    newSingleObject.testBoolean = @YES;
    newSingleObject.testNumber = @12345;
    newSingleObject.testDate = [NSDate date];
    
    // Create nested object
    
}


- (void)testTopLevelArray {
    
}


- (void)testObjectWithArrayOfObjects {
    
}


- (void)testNilProperties {
    
}

- (void)testMissingProperties {
    
}

@end

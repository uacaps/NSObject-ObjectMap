//
//  JSONTestCase.m
//  UnitTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "SingleObject.h"
#import "NestedObject.h"
#import "ObjectWithArray.h"
#import "XCTestCase+ObjectMapTestCategory.h"

@interface JSONTestCase : XCTestCase

@end

@implementation JSONTestCase

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

- (void)testSingleObject {
    //Create object to be serialized
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    
    //Serialize object, then deserialize it back to an object
    SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromJSONData:[testSingleObject JSONData]];
    
    //Test all properties
    [self testObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:@"testSingleObject" dataType:DataTypeJSON];
}


- (void)testNestedObject {
    // Create nested object
    NestedObject *testObject = [NestedObject newNestedObject];
    NestedObject *deserializedObject = [NSObject objectOfClass:@"NestedObject" fromJSONData:[testObject JSONData]];
    
    // Test Nested Object
    [self testObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:@"testNestedObject" dataType:DataTypeXML];
}


- (void)testTopLevelArray {
    // Create Arrays
    NSArray *arrayOfSingleObjects = @[[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject]];
    NSArray *arrayOfNestedObjects = @[[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject]];
    
    // Create deserializedObjects
    NSArray *deserializedSingleObjectArray = [NSObject objectOfClass:@"SingleObject" fromJSONData:[arrayOfSingleObjects JSONData]];
    NSArray *deserializedNestedObjectArray = [NSObject objectOfClass:@"NestedObject" fromJSONData:[arrayOfNestedObjects JSONData]];
    
    // Test Arrays
    [self testObject:arrayOfSingleObjects withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:@"testTopLevelArray-Single" dataType:DataTypeXML];
    [self testObject:arrayOfNestedObjects withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:@"testTopLevelArray-Nested" dataType:DataTypeXML];
}


- (void)testObjectWithArrayOfObjects {
    // Create Single Object Array
    ObjectWithArray *testSingleObjectArray = [ObjectWithArray newObjectWithArrayOfSingleObjects];
    SingleObject *deserializedSingleObjectArray = [NSObject objectOfClass:@"ObjectWithArray" fromJSONData:[testSingleObjectArray JSONData]];
    
    // Create Nested Object Array
    ObjectWithArray *testNestedObjectArray = [ObjectWithArray newObjectWithArrayOfNestedObjects];
    NestedObject *deserializedNestedObjectArray = [NSObject objectOfClass:@"ObjectWithArray" fromJSONData:[testNestedObjectArray JSONData]];
    
    // Test Arrays
    [self testObject:testSingleObjectArray withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:@"testObjectWithArrayOfObjects-Single" dataType:DataTypeXML];
    [self testObject:testNestedObjectArray withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:@"testObjectWithArrayOfObjects-Nested" dataType:DataTypeXML];
}


- (void)testNilProperties {
    
}

- (void)testMissingProperties {
    
}


@end

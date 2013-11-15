//
//  JSONTestCase.m
//  UnitTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "SingleObject.h"
#import "NestedObject.h"
#import "ObjectWithSingleObjectsArray.h"
#import "ObjectWithNestedObjectsArray.h"
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
    testSingleObject.testString = nil;
    
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
    [self testObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:@"testNestedObject" dataType:DataTypeJSON];
}


- (void)testTopLevelArray {
    // Create Arrays
    NSArray *arrayOfSingleObjects = @[[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject]];
    NSArray *arrayOfNestedObjects = @[[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject]];
    
    // Create deserializedObjects
    NSArray *deserializedSingleObjectArray = [NSObject objectOfClass:@"SingleObject" fromJSONData:[arrayOfSingleObjects JSONData]];
    NSArray *deserializedNestedObjectArray = [NSObject objectOfClass:@"NestedObject" fromJSONData:[arrayOfNestedObjects JSONData]];
    
    // Test Arrays
    [self testObject:arrayOfSingleObjects withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:@"testTopLevelArray-Single" dataType:DataTypeJSON];
    [self testObject:arrayOfNestedObjects withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:@"testTopLevelArray-Nested" dataType:DataTypeJSON];
}


- (void)testObjectWithArrayOfObjects {
    // Create Single Object Array
    ObjectWithSingleObjectsArray *testSingleObjectArray = [ObjectWithSingleObjectsArray newObjectWithArrayOfSingleObjects];
    SingleObject *deserializedSingleObjectArray = [NSObject objectOfClass:@"ObjectWithSingleObjectsArray" fromJSONData:[testSingleObjectArray JSONData]];
    
    // Create Nested Object Array
    ObjectWithNestedObjectsArray *testNestedObjectArray = [ObjectWithNestedObjectsArray newObjectWithArrayOfNestedObjects];
    NestedObject *deserializedNestedObjectArray = [NSObject objectOfClass:@"ObjectWithNestedObjectsArray" fromJSONData:[testNestedObjectArray JSONData]];
    
    // Test Arrays
    [self testObject:testSingleObjectArray withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:@"testObjectWithArrayOfObjects-Single" dataType:DataTypeJSON];
    [self testObject:testNestedObjectArray withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:@"testObjectWithArrayOfObjects-Nested" dataType:DataTypeJSON];
}


- (void)testMissingProperties {
    // Create Single Object with no Properties filled in
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromJSONData:[testSingleObject JSONData]];
    
    // Test
    [self testObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:@"testMissingProperties" dataType:DataTypeJSON];
}


- (void)testExtraProperties {
    // Create Single Object with no Properties filled in
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromJSONData:[[testSingleObject jsonStringWithExtraParameters] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:@"testExtraProperties" dataType:DataTypeJSON];
}

- (void)testExtraPropertiesInNestedArray {
    // Create Single Object with no Properties filled in
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    NSArray *extraPropertiesArray = @[[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject]];
    NSString *jsonArray = [NSString stringWithFormat:@"[%@,%@,%@]", [testSingleObject jsonStringWithExtraParameters], [testSingleObject jsonStringWithExtraParameters], [testSingleObject jsonStringWithExtraParameters]];
    NSArray *deserializedExtraPropertiesArray = [NSObject objectOfClass:@"SingleObject" fromJSONData:[jsonArray dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testObject:extraPropertiesArray withDeserializedVersion:deserializedExtraPropertiesArray forMethodNamed:@"testExtraPropertiesInNestedArray" dataType:DataTypeJSON];
}

- (void)testMalformedSerializedString {
    
}



@end

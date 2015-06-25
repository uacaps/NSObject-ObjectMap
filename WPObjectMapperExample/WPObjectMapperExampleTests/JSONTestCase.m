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
    // Serialize then Deserialize
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    SingleObject *deserializedObject = [[SingleObject alloc] initWithJSONData:[testSingleObject JSONData]];
    
    //Test all properties
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}


- (void)testNestedObject {
    // Serialize then Deserialize
    NestedObject *testObject = [NestedObject newNestedObject];
    NestedObject *deserializedObject = [[NestedObject alloc] initWithJSONData:[testObject JSONData]];
    
    // Test Nested Object
    [self testEqualityOfObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}


- (void)testTopLevelArray {
    // Create Arrays
    NSArray *arrayOfSingleObjects = @[[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject]];
    NSArray *arrayOfNestedObjects = @[[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject],[NestedObject newNestedObject]];
    
    // Create deserializedObjects
    NSArray *deserializedSingleObjectArray = [NSObject arrayOfType:[SingleObject class] FromJSONData:[arrayOfSingleObjects JSONData]];
    NSArray *deserializedNestedObjectArray = [NSObject arrayOfType:[NestedObject class] FromJSONData:[arrayOfNestedObjects JSONData]];
    
    // Test Arrays
    [self testEqualityOfObject:arrayOfSingleObjects withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
    [self testEqualityOfObject:arrayOfNestedObjects withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}


- (void)testObjectWithArrayOfObjects {
    // Create Single Object Array
    ObjectWithSingleObjectsArray *testSingleObjectArray = [ObjectWithSingleObjectsArray newObjectWithArrayOfSingleObjects];
    ObjectWithSingleObjectsArray *deserializedSingleObjectArray = [[ObjectWithSingleObjectsArray alloc] initWithJSONData:[testSingleObjectArray JSONData]];
    
    // Create Nested Object Array
    ObjectWithNestedObjectsArray *testNestedObjectArray = [ObjectWithNestedObjectsArray newObjectWithArrayOfNestedObjects];
    ObjectWithNestedObjectsArray *deserializedNestedObjectArray = [[ObjectWithNestedObjectsArray alloc] initWithJSONData:[testNestedObjectArray JSONData]];
    
    // Test Arrays
    [self testEqualityOfObject:testSingleObjectArray withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
    [self testEqualityOfObject:testNestedObjectArray withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}


- (void)testMissingProperties {
    // Create serializaed/deserialized Objects
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    testSingleObject.testString = nil;
    SingleObject *deserializedObject = [[SingleObject alloc] initWithJSONData:[testSingleObject JSONData]];
    
    // Test
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}


- (void)testExtraProperties {
    // Create serializaed/deserialized Objects
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    SingleObject *deserializedObject = [[SingleObject alloc] initWithJSONData:[[testSingleObject jsonStringWithExtraParameters] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}

- (void)testExtraPropertiesInNestedArray {
    // Create serializaed/deserialized Objects
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    NSArray *extraPropertiesArray = @[[SingleObject newSingleObject],[SingleObject newSingleObject],[SingleObject newSingleObject]];
    NSString *jsonArray = [NSString stringWithFormat:@"[%@,%@,%@]", [testSingleObject jsonStringWithExtraParameters], [testSingleObject jsonStringWithExtraParameters], [testSingleObject jsonStringWithExtraParameters]];
    NSArray *deserializedExtraPropertiesArray = [NSObject arrayOfType:[SingleObject class] FromJSONData:[jsonArray dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testEqualityOfObject:extraPropertiesArray withDeserializedVersion:deserializedExtraPropertiesArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}

- (void)testMalformedSerializedString {
    // Create serializaed/deserialized Objects
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    // Add character to JSON string
    SingleObject *deserializedObject = [[SingleObject alloc] initWithJSONData:[[[testSingleObject JSONString] stringByAppendingString:@"{"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testInequalityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}

-(void)testCustomInit{
    //Create object to be serialized
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    
    //Serialize object, then deserialize it back to an object
    SingleObject *deserializedObject = [[SingleObject alloc] initWithJSONData:[testSingleObject JSONData]];
    
    //Test all properties
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeJSON];
}

@end

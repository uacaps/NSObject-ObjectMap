//
//  XMLTestCase.m
//  UnitTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "XCTestCase+ObjectMapTestCategory.h"
#import "SingleObject.h"
#import "NestedObject.h"
#import "ObjectWithSingleObjectsArray.h"
#import "ObjectWithNestedObjectsArray.h"

@interface XMLTestCase : XCTestCase

@end

@implementation XMLTestCase

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

-(void)testSingleObject{
    //Create object to be serialized
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    
    //Serialize object, then deserialize it back to an object
    SingleObject *deserializedObject = [[SingleObject alloc] initWithXMLData:[testSingleObject XMLData]];
    
    //Test all properties
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

-(void)testNestedObject{
    //Create test object
    NestedObject *testObject = [NestedObject newNestedObject];
    
    //Serialize object, then deserialize it back to an object
    NestedObject *deserializedObject = [[NestedObject alloc] initWithXMLData:[testObject XMLData]];
    
    //Test all properties recursively
    [self testEqualityOfObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

-(void)testObjectWithArrayOfObjects{
    // Create Single Object Array
    ObjectWithSingleObjectsArray *testSingleObjectArray = [ObjectWithSingleObjectsArray newObjectWithArrayOfSingleObjects];
    ObjectWithSingleObjectsArray *deserializedSingleObjectArray = [[ObjectWithSingleObjectsArray alloc] initWithXMLData:[testSingleObjectArray XMLData]];
    
    // Create Nested Object Array
    ObjectWithNestedObjectsArray *testNestedObjectArray = [ObjectWithNestedObjectsArray newObjectWithArrayOfNestedObjects];
    ObjectWithNestedObjectsArray *deserializedNestedObjectArray = [[ObjectWithNestedObjectsArray alloc] initWithXMLData:[testNestedObjectArray XMLData]];
    
    // Test Arrays
    [self testEqualityOfObject:testSingleObjectArray withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
    [self testEqualityOfObject:testNestedObjectArray withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}


-(void)testMissingProperties{
    // Create Single Object with no Properties filled in
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    NSString *string = [testSingleObject XMLString];
    SingleObject *deserializedObject = [[SingleObject alloc] initWithXMLData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

-(void)testClosingTagNilObject{
    //Test Object
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    testSingleObject.testString = @"This is a test";
    
    //Build test string with closing tag nil object
    NSString *closingTagNilObjectString = @"<SingleObject><testString>This is a test</testString><testBoolean /></SingleObject>";
    
    //Deserialized object into SingleObject
    SingleObject *deserializedObject = [[SingleObject alloc] initWithXMLData:[closingTagNilObjectString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Test
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

- (void)testTopLevelArray {
    ObjectWithSingleObjectsArray *testSingleObjectArray = [ObjectWithSingleObjectsArray newObjectWithArrayOfSingleObjects];
    NSString *string = [testSingleObjectArray XMLString];
    string = [string stringByReplacingOccurrencesOfString:@"<ObjectWithSingleObjectsArray>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"</ObjectWithSingleObjectsArray>" withString:@""];
    
    ObjectWithSingleObjectsArray *deserializedSingleObjectArray = [[ObjectWithSingleObjectsArray alloc] initWithXMLData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Create Nested Object Array
    ObjectWithNestedObjectsArray *testNestedObjectArray = [ObjectWithNestedObjectsArray newObjectWithArrayOfNestedObjects];
    ObjectWithNestedObjectsArray *deserializedNestedObjectArray = [[ObjectWithNestedObjectsArray alloc] initWithXMLData:[testNestedObjectArray XMLData]];
    
    // Test Arrays
    [self testEqualityOfObject:testSingleObjectArray withDeserializedVersion:deserializedSingleObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
    [self testEqualityOfObject:testNestedObjectArray withDeserializedVersion:deserializedNestedObjectArray forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

-(void)testExtraProperties{
    
}

- (void)testMalformedSerializedString {
    // Create serializaed/deserialized Objects
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    // Add character to XML string
    NSString *badXML = [[testSingleObject XMLString] stringByReplacingOccurrencesOfString:@"Bool" withString:@"<"];
    SingleObject *deserializedObject = [[SingleObject alloc] initWithXMLData:[badXML dataUsingEncoding:NSUTF8StringEncoding]];
    //SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromXML:[testSingleObject XMLString]];
    
    // Test
    [self testInequalityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

-(void)testCustomInit{
    //Create object to be serialized
    SingleObject *testSingleObject = [SingleObject newSingleObject];
    
    //Serialize object, then deserialize it back to an object
    SingleObject *deserializedObject = [[SingleObject alloc] initWithXMLData:[testSingleObject XMLData]];
    
    //Test all properties
    [self testEqualityOfObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:__PRETTY_FUNCTION__ dataType:CAPSDataTypeXML];
}

@end

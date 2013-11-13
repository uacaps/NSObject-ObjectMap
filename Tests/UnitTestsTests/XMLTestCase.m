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
    SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromXML:[testSingleObject XMLString]];
    
    //Test all properties
    [self testObject:testSingleObject withDeserializedVersion:deserializedObject forMethodNamed:@"testSingleObject" dataType:DataTypeXML];
}

-(void)testNestedObject{
    //Create test object
    NestedObject *testObject = [NestedObject newNestedObject];
    
    //Serialize object, then deserialize it back to an object
    NestedObject *deserializedObject = [NSObject objectOfClass:@"NestedObject" fromXML:[testObject XMLString]];
    
    //Test all properties recursively
    [self testObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:@"testNestedObject" dataType:DataTypeXML];
}

-(void)testTopLevelArray{
    
}

-(void)testObjectWithArrayOfObjects{
    //Create test Object
    ObjectWithSingleObjectsArray *testObject = [ObjectWithSingleObjectsArray newObjectWithArrayOfSingleObjects];
    
    //Serialize object, then deserialize it back to an object
    ObjectWithSingleObjectsArray *deserializedObject = [NSObject objectOfClass:@"ObjectWithArray" fromXML:[testObject XMLString]];
    
    //Test all properties recursively
    [self testObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:@"testObjectWithArrayOfObjects" dataType:DataTypeXML];
}

-(void)testMissingProperties{
    
}

-(void)testExtraProperties{
    
}


@end

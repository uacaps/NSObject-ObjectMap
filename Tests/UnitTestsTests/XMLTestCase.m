//
//  XMLTestCase.m
//  UnitTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+ObjectMap.h"
#import "SingleObject.h"
#import "NestedObject.h"
#import "ObjectWithArray.h"
#import "TestHelpers.h"

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
    NestedObject *testObject = [[NestedObject alloc] init];
    testObject.singleObject = [SingleObject newSingleObject];
    
    NestedObject *deserializedObject = [NSObject objectOfClass:@"NestedObject" fromXML:[testObject XMLString]];
    
    [self testObject:testObject withDeserializedVersion:deserializedObject forMethodNamed:@"testNestedObject" dataType:DataTypeXML];
}

-(void)testTopLevelArray{
    
}

-(void)testObjectWithArrayOfObjects{
    
}

-(void)testNilProperties{
    
}

-(void)testMissingProperties{
    
}

-(void)testObject:(id)obj withDeserializedVersion:(id)deserializedObj forMethodNamed:(NSString *)methodName dataType:(DataType)type {
    //Test all properties
    for (NSString *propertyName in [deserializedObj propertyDictionary]) {
        if ([[deserializedObj valueForKey:propertyName] isKindOfClass:[NSDate class]]) {
            XCTAssertEqualWithAccuracy([[obj valueForKey:propertyName] timeIntervalSince1970], [[deserializedObj valueForKey:propertyName] timeIntervalSince1970], 0.01, @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
        else {
            XCTAssertEqualObjects([obj valueForKey:propertyName], [deserializedObj valueForKey:propertyName], @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
    }
}

- (NSString *)stringForType:(DataType)type {
    switch (type) {
        case DataTypeXML:
            return @"XML";
            break;
        case DataTypeJSON:
            return @"JSON";
            break;
        case DataTypeSOAP:
            return @"SOAP";
            break;
        default:
            return @"";
            break;
    }
}

@end

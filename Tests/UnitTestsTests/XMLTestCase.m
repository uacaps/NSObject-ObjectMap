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
    //Create date formatter for matching date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    
    NSDate *currentDate = [NSDate date];
    
    //Create object to be serialized
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    testSingleObject.testString = @"This is a test";
    testSingleObject.testBoolean = @YES;
    testSingleObject.testNumber = @123.5;
    testSingleObject.testDate = currentDate;
    
    //Serialize object, then deserialize it back to an object
    SingleObject *deserializedObject = [NSObject objectOfClass:@"SingleObject" fromXML:[testSingleObject XMLString]];
    
    //Test all properties
    for (NSString *propertyName in [deserializedObject propertyDictionary]) {
        if ([[deserializedObject valueForKey:propertyName] isKindOfClass:[NSDate class]]) {
            XCTAssertEqualWithAccuracy([[testSingleObject valueForKey:propertyName] timeIntervalSince1970], [[deserializedObject valueForKey:propertyName] timeIntervalSince1970], 0.01, @"Failed single object JSON serialization/deserialization test. Failed on property %@" ,propertyName);
        }
        else {
            XCTAssertEqualObjects([testSingleObject valueForKey:propertyName], [deserializedObject valueForKey:propertyName], @"Failed single object JSON serialization/deserialization test. Failed on property %@", propertyName);
        }
    }
}

-(void)testNestedObject{
    
}

-(void)testTopLevelArray{
    
}

-(void)testObjectWithArrayOfObjects{
    
}

-(void)testNilProperties{
    
}

-(void)testMissingProperties{
    
}

@end

//
//  XCTestCase+ObjectMapTestCategory.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "XCTestCase+ObjectMapTestCategory.h"

@implementation XCTestCase (ObjectMapTestCategory)


#pragma mark - TEST: Equality
- (void)testEqualityOfObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(const char*)methodName dataType:(CAPSDataType)type {
    XCTAssert([self testObject:testObj isEqualToDeserializedObject:deserializedObj forType:type], @"Failed %@ equality of serialization/deserialization test for method named: %s.", [self stringForType:type], methodName);
}


#pragma mark - TEST: Inequality
- (void)testInequalityOfObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(const char*)methodName dataType:(CAPSDataType)type {
    XCTAssertFalse([self testObject:testObj isEqualToDeserializedObject:deserializedObj forType:type], @"Failed %@ inequality of serialization/deserialization test for method named: %s.", [self stringForType:type], methodName);
}



#pragma mark - Are Objects Equal Method
- (BOOL)testObject:(id)testObj isEqualToDeserializedObject:(id)deserializedObj forType:(CAPSDataType)type {
    // Set Up
    BOOL isEqual;
    
    // Test for one's nilness and the other's non-nilness
    if ((testObj == nil && deserializedObj != nil) || (testObj != nil && deserializedObj == nil)) {
        return NO;
    }
    
    //Test all properties
    for (NSString *propertyName in [deserializedObj propertyDictionary]) {
        //Get instance of property
        id deserializedPropertyInstance = [deserializedObj valueForKey:propertyName];
        id testPropertyInstance = [testObj valueForKey:propertyName];
        
        // Test property equality
        if ([deserializedPropertyInstance isKindOfClass:[NSDate class]]) {
            if (deserializedPropertyInstance && testPropertyInstance) {
                int date1TimeInt = [[testObj valueForKey:propertyName] timeIntervalSince1970];
                int date2TimeInt = [[deserializedObj valueForKey:propertyName] timeIntervalSince1970];
                isEqual = date1TimeInt-date2TimeInt == 0;
            }
        }
        else if ([deserializedPropertyInstance isKindOfClass:[NSString class]]) {
            isEqual = [(NSString *)[testObj valueForKey:propertyName] isEqualToString:(NSString *)[deserializedObj valueForKey:propertyName]];
        }
        else if ([deserializedPropertyInstance isKindOfClass:[NSNumber class]]){
            isEqual = [(NSNumber *)[testObj valueForKey:propertyName] isEqualToNumber:(NSNumber *)[deserializedObj valueForKey:propertyName]];
        }
        else if ([deserializedPropertyInstance isKindOfClass:[NSArray class]]) {
            // Create block BOOL
            __block BOOL isEqualBlock;
            
            //Iterate over all objects and test them!
            [deserializedPropertyInstance enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                isEqualBlock = [self testObject:[(NSArray *)testPropertyInstance objectAtIndex:idx] isEqualToDeserializedObject:[(NSArray *)deserializedPropertyInstance objectAtIndex:idx] forType:type];
                *stop = !isEqualBlock;
            }];
            
            // Finally set isEqual
            isEqual = isEqualBlock;
        }
        else if ([testPropertyInstance isKindOfClass:[NSDictionary class]] && (type == CAPSDataTypeXML || type == CAPSDataTypeSOAP)) {
            // XML/SOAP doesn't have the concept of Dictionary - everything is an object, an array, or a type of some sort
            isEqual = YES;
            continue;
        }
        else {
            //It's a complex object of some kind
            isEqual = [self testObject:[testObj valueForKey:propertyName] isEqualToDeserializedObject:deserializedPropertyInstance forType:type];
        }
        
        
        // Return NO if the property is not equal
        if (isEqual == NO) {
            return NO;
        }
    }
    
    return YES;
}


#pragma mark - String for Type
- (NSString *)stringForType:(CAPSDataType)type {
    switch (type) {
        case CAPSDataTypeXML:
            return @"XML";
            break;
        case CAPSDataTypeJSON:
            return @"JSON";
            break;
        case CAPSDataTypeSOAP:
            return @"SOAP";
            break;
        default:
            return @"";
            break;
    }
}

@end

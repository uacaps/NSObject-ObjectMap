//
//  XCTestCase+ObjectMapTestCategory.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "XCTestCase+ObjectMapTestCategory.h"

@implementation XCTestCase (ObjectMapTestCategory)

- (void)testObject:(id)testObj withDeserializedVersion:(id)deserializedObj forMethodNamed:(NSString *)methodName dataType:(DataType)type {
    //Test all properties
    for (NSString *propertyName in [deserializedObj propertyDictionary]) {
        
        //Get instance of property
        id deserializedPropertyInstance = [deserializedObj valueForKey:propertyName];
        id testPropertyInstance = [testObj valueForKey:propertyName];
        
        if ([deserializedPropertyInstance isKindOfClass:[NSDate class]]) {
            if (deserializedPropertyInstance && testPropertyInstance) {
                XCTAssertEqualWithAccuracy([[testObj valueForKey:propertyName] timeIntervalSince1970], [[deserializedObj valueForKey:propertyName] timeIntervalSince1970], 0.01, @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
            }
        }
        else if ([deserializedPropertyInstance isKindOfClass:[NSString class]] || [deserializedPropertyInstance isKindOfClass:[NSNumber class]]){
            XCTAssertEqualObjects([testObj valueForKey:propertyName], [deserializedObj valueForKey:propertyName], @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
        else if ([deserializedPropertyInstance isKindOfClass:[NSArray class]]) {
            //Iterate over all objects and test them!
            [deserializedPropertyInstance enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self testObject:[(NSArray *)testPropertyInstance objectAtIndex:idx] withDeserializedVersion:[(NSArray *)deserializedPropertyInstance objectAtIndex:idx] forMethodNamed:methodName dataType:type];
            }];
        }
        else if ([deserializedPropertyInstance isKindOfClass:[NSDictionary class]] && (type == DataTypeXML || type == DataTypeSOAP)) {
            // XML/SOAP doesn't have the concept of Dictionary - everything is an object, an array, or a type of some sort
            continue;
        }
        else { //It's a complex object of some kind
            [self testObject:[testObj valueForKey:propertyName] withDeserializedVersion:deserializedPropertyInstance forMethodNamed:methodName dataType:type];
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

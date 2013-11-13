//
//  XCTestCase+ObjectMapTestCategory.m
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "XCTestCase+ObjectMapTestCategory.h"

@implementation XCTestCase (ObjectMapTestCategory)

- (void)testObject:(id)obj withDeserializedVersion:(id)deserializedObj forMethodNamed:(NSString *)methodName dataType:(DataType)type {
    //Test all properties
    for (NSString *propertyName in [deserializedObj propertyDictionary]) {
        
        //Get instance of property
        id propertyInstance = [deserializedObj valueForKey:propertyName];
        
        if ([propertyInstance isKindOfClass:[NSDate class]]) {
            XCTAssertEqualWithAccuracy([[obj valueForKey:propertyName] timeIntervalSince1970], [[deserializedObj valueForKey:propertyName] timeIntervalSince1970], 0.01, @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
        else if ([propertyInstance isKindOfClass:[NSString class]] || [propertyInstance isKindOfClass:[NSNumber class]]){
            XCTAssertEqualObjects([obj valueForKey:propertyName], [deserializedObj valueForKey:propertyName], @"Failed %@ serialization/deserialization test for method named: %@. Failed on property %@", [self stringForType:type], methodName, propertyName);
        }
        else if ([propertyInstance isKindOfClass:[NSArray class]]) {
            
        }
        else { //It's a complex object of some kind
            [self testObject:[obj valueForKey:propertyName] withDeserializedVersion:propertyInstance forMethodNamed:methodName dataType:type];
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

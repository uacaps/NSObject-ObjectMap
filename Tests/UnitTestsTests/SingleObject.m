//
//  SingleObject.m
//  ObjectMapTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "SingleObject.h"
#import "NSObject+ObjectMap.h"

@implementation SingleObject

+(SingleObject *)newSingleObject{
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
    testSingleObject.testDict = @{@"Hello":@"World"};
    
    return testSingleObject;
}

- (NSString *)jsonStringWithExtraParameters {
    NSScanner *scanner = [NSScanner scannerWithString:[self JSONString]];
    NSString *newJSONString = @"";
    NSString *remainingJSONString = @"";
    [scanner scanUpToString:@"," intoString:&newJSONString];
    newJSONString = [newJSONString stringByAppendingString:@", \"Hello\":\"World\""];
    [scanner scanUpToString:@"END_OF_STRING" intoString:&remainingJSONString];
    newJSONString = [newJSONString stringByAppendingString:remainingJSONString];
    return newJSONString;
}

+ (SingleObject *)malformedSingleObject {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    
    NSDate *currentDate = [NSDate date];
    
    //Create object to be serialized
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    testSingleObject.testBoolean = @YES;
    testSingleObject.testNumber = @123.5;
    testSingleObject.testDate = currentDate;
    testSingleObject.testDict = @{@"Hello":@"World"};
    
    return testSingleObject;
}

+ (NSString *)malformedJSONString {
    return @"";
}

@end

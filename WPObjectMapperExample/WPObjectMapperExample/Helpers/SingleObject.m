//
//  SingleObject.m
//  ObjectMapTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <WPObjectMapper/NSObject+ObjectMap.h>
#import <WPFaker/WPFaker.h>

#import "SingleObject.h"

@implementation SingleObject

+(SingleObject *)newSingleObject{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
//    
//    NSDate *currentDate = [NSDate date];
    RandomNumber *random = [[RandomNumber alloc] init];

    //Create object to be serialized
    SingleObject *testSingleObject = [[SingleObject alloc] init];
    testSingleObject.testString = [MBFakerLorem words: 5];
    testSingleObject.testBoolean = [random inRange: 0 high: 500].integerValue > 250 ? @YES : @NO;
    testSingleObject.testNumber = [random inRange: 0 high: 500];
    testSingleObject.testDate = [[[Dates alloc] init] minutesAgoAsDate: [random inRange: 0 high: 60].integerValue];
    testSingleObject.testDict = @{[MBFakerLorem word]: [MBFakerLorem paragraph]};

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

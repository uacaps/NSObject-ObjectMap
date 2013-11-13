//
//  SingleObject.m
//  ObjectMapTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import "SingleObject.h"

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
    
    return testSingleObject;
}
@end

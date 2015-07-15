//
//  WPFakerDate.m
//  Example
//
//  Created by Soper, Sean on 7/6/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

#import "WPFakerDate.h"

@implementation WPFakerDate

+ (instancetype) sharedInstance {
    static id sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Dates alloc] init];
    });

    return sharedInstance;
}

+ (NSNumber *) minutesAgoAsEpoch:(NSUInteger) minutes {
    return [[self sharedInstance] minutesAgoAsEpoch: minutes];
}

+ (NSString *) minutesAgo:(NSUInteger) minutes {
    return [[self sharedInstance] minutesAgo: minutes];
}

+ (NSString *) minutesAgo:(NSUInteger) minutes
                  options:(TestDatesFormat) options {
    return [[self sharedInstance] minutesAgo: minutes options: options];
}

+ (NSDate *) minutesAgoAsDate:(NSUInteger) minutes {
    return [[self sharedInstance] minutesAgoAsDate: minutes];
}

+ (NSDate *) dateFromString:(NSString *) dateStr
                    options:(TestDatesFormat) options {
    return [[self sharedInstance] dateFromString: dateStr options: options];
}

@end

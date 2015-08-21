//
//  WPFakerNumber.m
//  Example
//
//  Created by Soper, Sean on 7/6/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

#import "WPFakerNumber.h"

@implementation WPFakerNumber

+ (instancetype) sharedInstance {
    static id sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RandomNumber alloc] init];
    });

    return sharedInstance;
}

+ (NSNumber *) inRange:(NSUInteger) low
                  high:(NSUInteger) high {
    return [[self sharedInstance] inRange: low high: high];
}

+ (NSString *) twitterIdStr {
    return [[self sharedInstance] twitterIdStr];
}

+ (NSNumber *) trueOrFalse {
    return [[self sharedInstance] trueOrFalse];
}

@end

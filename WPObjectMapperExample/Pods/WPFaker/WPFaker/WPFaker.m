//
//  WPFaker.m
//  Rainbow
//
//  Created by Soper, Sean on 10/29/14.
//  Copyright (c) 2014 Washington Post. All rights reserved.
//

#import "WPFaker.h"
#import "YAMLSerialization.h"

@implementation MBFakerInternet (WP)

+ (NSString *) path {
    NSUInteger numComponents = 5;
    NSMutableArray *components = [[NSMutableArray alloc] initWithCapacity: numComponents];
    for (int i = 0; i < numComponents; i++)
        [components addObject: [MBFakerInternet userName]];

    return [@"/" stringByAppendingString: [components componentsJoinedByString: @"/"]];
}

+ (NSString *) uuid {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidString;
}

@end

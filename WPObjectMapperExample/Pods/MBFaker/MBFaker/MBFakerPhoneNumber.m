//
//  MBFakerPhoneNumber.m
//  Faker
//
//  Created by Michał Banasiak on 11/6/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerPhoneNumber.h"
#import "MBFaker.h"

@implementation MBFakerPhoneNumber

+ (NSString*)phoneNumber {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"phone_number.formats"];
}

@end

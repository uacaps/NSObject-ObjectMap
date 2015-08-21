//
//  MBFakerCompany.m
//  Faker
//
//  Created by Michał Banasiak on 11/6/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerCompany.h"
#import "MBFaker.h"

@implementation MBFakerCompany

+ (NSString*)name {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"company.name"];
}

+ (NSString*)suffix {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"company.suffix"];
}

@end

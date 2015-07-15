//
//  MBFakerName.m
//  Faker
//
//  Created by Michał Banasiak on 10/29/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerName.h"
#import "MBFaker.h"

@implementation MBFakerName

+ (NSString*)name {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"name.name"];
}

+ (NSString*)firstName {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"name.first_name"];
}

+ (NSString*)lastName {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"name.last_name"];
}

+ (NSString*)prefix {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"name.prefix"];
}

+ (NSString*)suffix {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"name.suffix"];    
}

@end

//
//  MBFakerAddress.m
//  Faker
//
//  Created by Michał Banasiak on 10/31/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerAddress.h"
#import "MBFaker.h"

@implementation MBFakerAddress

+ (NSString*)city {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.city"];
}

+ (NSString*)streetName {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.street_name"];    
}

+ (NSString*)streetAddress {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.street_address"];    
}

+ (NSString*)streetAddressWithSecondaryAddress {
    return [NSString stringWithFormat:@"%@ %@", [MBFakerAddress streetAddress], [MBFakerAddress secondaryAddress]];
}

+ (NSString*)secondaryAddress {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.secondary_address"];    
}

+ (NSString*)buildingNumber {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.building_number"];    
}

+ (NSString*)zipCode {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.postcode"];    
}

+ (NSString*)zip {
    return [MBFakerAddress zipCode];
}

+ (NSString*)postCode {
    return [MBFakerAddress zipCode];
}

+ (NSString*)streetSuffix {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.street_suffix"];    
}

+ (NSString*)citySuffix {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.city_suffix"];    
}

+ (NSString*)cityPrefix {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.city_prefix"];    
}

+ (NSString*)stateAbbr {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.state_abbr"];    
}

+ (NSString*)state {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.state"];    
}

+ (NSString*)country {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"address.country"];    
}

+ (NSString*)latitude {
    return [[NSNumber numberWithDouble: arc4random()*180-90] stringValue];
}

+ (NSString*)longitude {
    return [[NSNumber numberWithDouble: arc4random()*360-180] stringValue];
}

@end

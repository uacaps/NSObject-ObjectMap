//
//  MBFakerAddress.h
//  Faker
//
//  Created by Michał Banasiak on 10/31/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFakerAddress : NSObject

+ (NSString*)city;
+ (NSString*)streetName;
+ (NSString*)streetAddress;
+ (NSString*)streetAddressWithSecondaryAddress;
+ (NSString*)secondaryAddress;
+ (NSString*)buildingNumber;
+ (NSString*)zipCode;
+ (NSString*)zip;
+ (NSString*)postCode;
+ (NSString*)streetSuffix;
+ (NSString*)citySuffix;
+ (NSString*)cityPrefix;
+ (NSString*)stateAbbr;
+ (NSString*)state;
+ (NSString*)country;
+ (NSString*)latitude;
+ (NSString*)longitude;

@end

//
//  MBFakerInternet.h
//  Faker
//
//  Created by Michał Banasiak on 11/7/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFakerInternet : NSObject

+ (NSString*)email;
+ (NSString*)freeEmail;
+ (NSString*)safeEmail;
+ (NSString*)userName;
+ (NSString*)domainName;
+ (NSString*)domainWord;
+ (NSString*)domainSuffix;
+ (NSString*)ipV4Address;
+ (NSString*)ipV6Address;
+ (NSString*)url;

@end

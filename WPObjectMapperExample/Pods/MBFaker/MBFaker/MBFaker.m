//
//  MBFaker.m
//  Faker
//
//  Created by Michał Banasiak on 10/29/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFaker.h"

@interface MBFaker () {
    NSDictionary* translations;
}

- (void)fetchTranslations;

@end

@implementation MBFaker

+ (MBFaker*)sharedFaker {
    static MBFaker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MBFaker alloc] init];
        [sharedInstance fetchTranslations];
        sharedInstance.language = @"en";
    });
    
    return sharedInstance;
}

+ (void)setLanguage:(NSString *)language {
    [[MBFaker sharedFaker] setLanguage:language];
}

- (NSArray*)availableLanguages {
    return [[MBFakerHelper translations] allKeys];
}

- (NSString *)fetchStringWithKey:(NSString *)key {
    return [MBFakerHelper fetchRandomElementWithKey:key withLanguage:_language fromTranslationsDictionary:translations];
}

- (void)fetchTranslations {
    translations = [MBFakerHelper translations];
}


@end

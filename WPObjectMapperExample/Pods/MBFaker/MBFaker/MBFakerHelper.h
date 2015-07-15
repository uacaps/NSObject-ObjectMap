//
//  MBFakerHelper.h
//  Faker
//
//  Created by Michał Banasiak on 10/29/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFakerHelper : NSObject

+ (NSDictionary*)translations;
+ (NSDictionary*)dictionaryForLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations;
+ (NSArray*)fetchDataWithKey:(NSString*)key withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations;
+ (NSString*)fetchRandomElementWithKey:(NSString*)key withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations;
+ (NSString*)fetchDataWithTemplate:(NSString*)dataTemplate withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations;
+ (NSString*)numberWithTemplate:(NSString*)numberTemplate fromTranslationsDictionary:(NSDictionary*)translations;

@end

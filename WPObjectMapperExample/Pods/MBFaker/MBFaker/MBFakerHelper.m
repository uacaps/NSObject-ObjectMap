//
//  MBFakerHelper.m
//  Faker
//
//  Created by Michał Banasiak on 10/29/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerHelper.h"
#import "YAMLSerialization.h"


@implementation MBFakerHelper

+ (NSDictionary*)translations {
    NSMutableDictionary* translationsDictionary = [[NSMutableDictionary alloc] init];
    
    NSArray* translationPaths = [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"yml" inDirectory:@""];
    
    for (NSString* path in translationPaths) {
        NSInputStream *stream = [[NSInputStream alloc] initWithFileAtPath: path];
        
        NSMutableArray* yaml = [YAMLSerialization YAMLWithStream: stream
                                                         options: kYAMLReadOptionStringScalars
                                                           error: NULL];
        
        NSDictionary* dictionary = (NSDictionary*)[yaml objectAtIndex:0];
        
        NSString* key = [[dictionary allKeys] objectAtIndex:0];
        
        [translationsDictionary setObject: [dictionary objectForKey:key] forKey:key];
    }
    
    return (NSDictionary*)translationsDictionary;
}

+ (NSDictionary*)dictionaryForLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSDictionary* dictionary = [translations objectForKey:language];
    
    return [dictionary objectForKey:@"faker"];
}

+ (NSArray*)fetchDataWithKey:(NSString*)key withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSDictionary* dictionary = [MBFakerHelper dictionaryForLanguage:language fromTranslationsDictionary:translations];
    
    NSArray* parsedKey = [key componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    
    if ([parsedKey count] == 1)
        return [dictionary objectForKey:key];
    else {
        id parsedObject = [dictionary objectForKey:[parsedKey objectAtIndex:0]];
        
        for (int i=1; i<[parsedKey count]; i++)
            parsedObject = [parsedObject objectForKey:[parsedKey objectAtIndex:i]];
        
        return (NSArray*)parsedObject;
    }
    
    return nil;
}

+ (NSString*)fetchRandomElementWithKey:(NSString*)key withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSString* lowercaseKey = [key lowercaseString];
    
    NSArray* elements = [MBFakerHelper fetchDataWithKey:lowercaseKey withLanguage:language fromTranslationsDictionary:translations];
    
    if ([elements count] > 0) {
        NSInteger randomIndex = arc4random() % [elements count];
        
        NSString* fetchedString = [elements objectAtIndex:randomIndex];
        
        return [MBFakerHelper fetchDataWithTemplate:fetchedString withLanguage:language fromTranslationsDictionary:translations];
    }
    
    return nil;
}

+ (NSString*)fetchDataWithTemplate:(NSString*)dataTemplate withLanguage:(NSString*)language fromTranslationsDictionary:(NSDictionary*)translations {
    NSRange hashRange = [dataTemplate rangeOfString:@"#"];
    
    if (hashRange.location != NSNotFound) {
        NSRange templateRange = [dataTemplate rangeOfString:@"#{"];
        
        if (templateRange.location == NSNotFound)
            return [MBFakerHelper numberWithTemplate:dataTemplate fromTranslationsDictionary:translations];
    } else {
		return dataTemplate;
	}
    
    NSArray* components = [dataTemplate componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{#}"]];
        
    NSMutableArray* parsedTemplate = [[NSMutableArray alloc] init];
    
    for (NSString* component in components)
        if ([component length] > 0)
            [parsedTemplate addObject:component];
	
	NSString* fetchedString = @"";
	
	for (NSString* parsedElement in parsedTemplate) {
		if ([parsedElement compare:@" "] == 0)
			fetchedString = [fetchedString stringByAppendingString:@" "];
		else {
			NSString* stringToAppend = [MBFakerHelper fetchRandomElementWithKey:parsedElement withLanguage:language fromTranslationsDictionary:translations];
			
			if (stringToAppend)
				fetchedString = [fetchedString stringByAppendingString:stringToAppend];
			else
				fetchedString = [fetchedString stringByAppendingString:parsedElement];
		}
		
	}
	
	if ([fetchedString compare:@""] == 0)
		return nil;
	else
		return fetchedString;
}

+ (NSString*)numberWithTemplate:(NSString *)numberTemplate fromTranslationsDictionary:(NSDictionary*)translations {
    NSString* numberString = @"";
    
    for (int i=0; i<[numberTemplate length]; i++) {
        if ([numberTemplate characterAtIndex:i] == '#')
            numberString = [numberString stringByAppendingFormat:@"%d", arc4random()%10];
        else
            numberString = [numberString stringByAppendingString:[numberTemplate substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return numberString;
}

@end

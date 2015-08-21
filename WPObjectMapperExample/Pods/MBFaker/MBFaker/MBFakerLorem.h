//
//  MBFakerLorem.h
//  Faker
//
//  Created by Michał Banasiak on 11/6/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFakerLorem : NSObject

+ (NSString*)word;
+ (NSString*)words:(NSInteger)numberOfWords;
+ (NSString*)characters:(NSInteger)numberOfCharacters;
+ (NSString*)numbers:(NSInteger)numberOfNumbers;
+ (NSString*)sentence;
+ (NSString*)sentenceWithNumberOfWords:(NSInteger)numberOfWords;
+ (NSString*)sentences:(NSInteger)numberOfSentences;
+ (NSString*)paragraph;
+ (NSString*)paragraphWithNumberOfSentences:(NSInteger)numberOfSentences;
+ (NSString*)paragraphs;
+ (NSString*)paragraphs:(NSInteger)numberOfParagraphs;

@end

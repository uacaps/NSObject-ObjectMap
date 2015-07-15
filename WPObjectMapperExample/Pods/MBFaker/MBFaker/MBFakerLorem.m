//
//  MBFakerLorem.m
//  Faker
//
//  Created by Michał Banasiak on 11/6/12.
//  Copyright (c) 2012 Michał Banasiak. All rights reserved.
//

#import "MBFakerLorem.h"
#import "MBFaker.h"

@implementation MBFakerLorem

+ (NSString*)word {
    return [[MBFaker sharedFaker] fetchStringWithKey:@"lorem.words"];
}

+ (NSString*)words:(NSInteger)numberOfWords {
    NSMutableArray *words = [[NSMutableArray alloc] initWithCapacity:numberOfWords];
    
    for (int i=0; i<numberOfWords; i++)
        [words addObject:[[MBFaker sharedFaker] fetchStringWithKey:@"lorem.words"]];
    
    return [words componentsJoinedByString:@" "];
}


+ (NSString*)characters:(NSInteger)numberOfCharacters {
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:numberOfCharacters];
    
    for (int i=0; i<numberOfCharacters; i++)
        [characters addObject:[NSString stringWithFormat:@"%c", arc4random()%(122-97) + 97]];
    
    return [characters componentsJoinedByString:@""];
}

+ (NSString*)numbers:(NSInteger)numberOfNumbers {
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:numberOfNumbers];
    
    for (int i=0; i<numberOfNumbers; i++)
        [numbers addObject:[NSString stringWithFormat:@"%i", arc4random()%10]];
    
    return [numbers componentsJoinedByString:@""];
}

+ (NSString*)sentence {
    return [MBFakerLorem sentenceWithNumberOfWords:arc4random()%6 + 4];
}

+ (NSString*)sentenceWithNumberOfWords:(NSInteger)numberOfWords {
    NSMutableArray* words = [[NSMutableArray alloc] initWithCapacity:numberOfWords];
    
    [words addObject:[[MBFakerLorem word] capitalizedString]];
    
    for (int i=1; i<numberOfWords; i++)
         [words addObject:[MBFakerLorem word]];
        
    NSString* sentence = [words componentsJoinedByString:@" "];
    sentence = [sentence stringByAppendingString:@"."];
    
    return sentence;
}

+ (NSString*)sentences:(NSInteger)numberOfSentences {
    NSMutableArray *sentences = [[NSMutableArray alloc] initWithCapacity:numberOfSentences];
    
    for (int i=0; i<numberOfSentences; i++)
         [sentences addObject:[MBFakerLorem sentence]];
    
    return [sentences componentsJoinedByString:@" "];
}

+ (NSString*)paragraph {
    return [MBFakerLorem paragraphWithNumberOfSentences:arc4random()%6 + 3];
}

+ (NSString*)paragraphWithNumberOfSentences:(NSInteger)numberOfSentences {
    return [MBFakerLorem sentences:numberOfSentences];
}

+ (NSString*)paragraphs {
    return [MBFakerLorem paragraphs:arc4random()%6 + 3];
}

+ (NSString*)paragraphs:(NSInteger)numberOfParagraphs {
    NSMutableArray *paragraphs = [[NSMutableArray alloc] initWithCapacity:numberOfParagraphs];
    
    for (int i=0; i<numberOfParagraphs; i++)
         [paragraphs addObject:[MBFakerLorem paragraph]];
    
    return [paragraphs componentsJoinedByString:@"\n"];
}

@end

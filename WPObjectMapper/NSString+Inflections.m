//
//  NSString+Inflections.m
//  WashPost
//
//  Created by Sean Soper on 12/17/13.
//  Copyright (c) 2013 Washington Post. All rights reserved.
//

#import "NSString+Inflections.h"

@implementation NSString (Inflections)

- (NSString *)underscore {
  NSScanner *scanner = [NSScanner scannerWithString:self];
  scanner.caseSensitive = YES;
  
  NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
  NSCharacterSet *lowercase = [NSCharacterSet lowercaseLetterCharacterSet];
  
  NSString *buffer = nil;
  NSMutableString *output = [NSMutableString string];
  
  while (scanner.isAtEnd == NO) {
    
    if ([scanner scanCharactersFromSet:uppercase intoString:&buffer]) {
      [output appendString:[buffer lowercaseString]];
    }
    
    if ([scanner scanCharactersFromSet:lowercase intoString:&buffer]) {
      [output appendString:buffer];
      if (!scanner.isAtEnd)
        [output appendString:@"_"];
    }
  }
  
  return [NSString stringWithString:output];
}

- (NSString *)camelcase {
  NSArray *components = [self componentsSeparatedByString:@"_"];
  NSMutableString *output = [NSMutableString string];
  
  for (NSUInteger i = 0; i < components.count; i++) {
    if (i == 0) {
      [output appendString:components[i]];
    } else {
      [output appendString:[components[i] capitalizedString]];
    }
  }
  
  return [NSString stringWithString:output];
}

- (NSString *)classify {
  NSString *camelcase = [self camelcase];
  return [camelcase stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[camelcase substringWithRange:NSMakeRange(0, 1)] uppercaseString]];
}

@end

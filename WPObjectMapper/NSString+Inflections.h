//
//  NSString+Inflections.h
//  WashPost
//
//  Created by Sean Soper on 12/17/13.
//  Copyright (c) 2013 Washington Post. All rights reserved.
//

@import Foundation;

@interface NSString (Inflections)

- (NSString *)underscore;
- (NSString *)camelcase;
- (NSString *)classify;

@end

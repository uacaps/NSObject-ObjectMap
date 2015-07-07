//
//  WPFakerNumber.h
//  Example
//
//  Created by Soper, Sean on 7/6/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

/*
 * @see RandomNumber
 */

#import "RandomNumber.h"

@interface WPFakerNumber : NSObject

+ (NSNumber *) inRange:(NSUInteger) low
                  high:(NSUInteger) high;

+ (NSString *) twitterIdStr;

+ (NSNumber *) trueOrFalse;

@end

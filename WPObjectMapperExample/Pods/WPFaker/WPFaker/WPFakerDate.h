//
//  WPFakerDate.h
//  Example
//
//  Created by Soper, Sean on 7/6/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

/*
 * @see Dates
 */

#import "Dates.h"

@interface WPFakerDate : NSObject

+ (NSNumber *) minutesAgoAsEpoch:(NSUInteger) minutes;

+ (NSString *) minutesAgo:(NSUInteger) minutes;

+ (NSString *) minutesAgo:(NSUInteger) minutes
                  options:(TestDatesFormat) options;

+ (NSDate *) minutesAgoAsDate:(NSUInteger) minutes;

+ (NSDate *) dateFromString:(NSString *) dateStr
                    options:(TestDatesFormat) options;

@end

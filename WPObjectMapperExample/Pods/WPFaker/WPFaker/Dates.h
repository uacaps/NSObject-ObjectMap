//
//  Dates.h
//  WashPost
//
//  Created by Soper, Sean on 9/23/13.
//  Copyright (c) 2013 Washington Post. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Enumerates supported date formats for the helper.
 *  
 *  - TestDatesFormatDefault: Wed, 14 Jan 2015 22:41:33 GMT
 *  - TestDatesFormatBundle: 2015-01-14T22:41:33+0000
 *  - TestDatesFormatTwitter: Wed Jan 14 22:41:33 GMT 2015
 * 
 *  @see minutesAgo:options:
 *  @see dateFromString:options:
 */
typedef NS_ENUM(NSUInteger, TestDatesFormat){
    TestDatesFormatDefault,
    TestDatesFormatBundle,
    TestDatesFormatTwitter
};

/**
 *  Contains several helper methods for generating dates and strings of dates in various formats for testing purposes.
 */
@interface Dates : NSObject

/**
 *  Calculates an epoch timestamp from the past, relative to the current date & time.
 *
 *  @param minutes The number of minutes in the past.
 *
 *  @return An epoch timestamp for the specified relative time in the past.
 */
- (NSNumber *) minutesAgoAsEpoch:(NSUInteger) minutes;

/**
 *  Calculates an epoch timestamp from the past, relative to the current date & time, with default options.
 *
 *  @see minutesAgo:options:
 */
- (NSString *) minutesAgo:(NSUInteger) minutes;

/**
 *  Generates a formatted date string from a time in the past, relative to the current date & time.
 *
 *  @param minutes The number of minutes in the past.
 *  @param options The type of string formatting to use when creating the string.
 *
 *  @return A formatted date string.
 *  
 *  @see TestDatesFormat
 */
- (NSString *) minutesAgo:(NSUInteger) minutes
                  options:(TestDatesFormat) options;

/**
 *  Generates an NSDate for a time in the past, relative to the current date & time.
 *
 *  @param minutes The number of minutes in the past.
 *
 *  @return The generated date.
 */
- (NSDate *) minutesAgoAsDate:(NSUInteger) minutes;

/**
 *  Parses an NSString into an NSDate object, using the specified format.
 *
 *  @param dateStr The string to be parsed into a date.
 *  @param options The type of string formatting to use when parsing the string.
 *
 *  @return The parsed date.
 *
 *  @see TestDatesFormat
 */
- (NSDate *) dateFromString:(NSString *) dateStr
                    options:(TestDatesFormat) options;

@end

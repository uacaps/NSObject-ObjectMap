//
//  Dates.m
//  WashPost
//
//  Created by Soper, Sean on 9/23/13.
//  Copyright (c) 2013 Washington Post. All rights reserved.
//

#import "Dates.h"

@implementation Dates

- (NSNumber *) minutesAgoAsEpoch:(NSUInteger) minutes {
    return @(round(([[NSDate date] timeIntervalSince1970] - (minutes * 60))*1000));
}

- (NSString *) minutesAgo:(NSUInteger) minutes {
  return [self minutesAgo: minutes options: TestDatesFormatDefault];
}

- (NSString *) minutesAgo:(NSUInteger) minutes
                  options:(NSUInteger) options {
  return [self minutesAgo: minutes format: [self formatFromOptions: options]];
}

- (NSDate *) minutesAgoAsDate:(NSUInteger) minutes {
  NSTimeInterval interval = (minutes*60);
  return [NSDate dateWithTimeIntervalSinceNow: -interval];
}

- (NSDate *) dateFromString:(NSString *) dateStr
                    options:(NSUInteger) options {
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat: [self formatFromOptions: options]];

  return [dateFormat dateFromString: dateStr];
}

#pragma mark - Private

- (NSString *) minutesAgo:(NSUInteger) minutes
                   format:(NSString *) format {
  NSDate *date = [self minutesAgoAsDate: minutes];
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
  [dateFormat setDateFormat: format];
  
  return [dateFormat stringFromDate: date];
}

- (NSString *) formatFromOptions:(NSUInteger) options {
  NSString *format = @"EE, d LLL yyyy HH:mm:ss z";
  switch (options) {
    case TestDatesFormatBundle:
      format = @"yyyy-MM-dd'T'HH:mm:ssZZZ";
      break;
    case TestDatesFormatTwitter:
      format = @"eee MMM dd HH:mm:ss ZZZZ yyyy";
      break;
    default:
      break;
  }

  return format;
}

@end

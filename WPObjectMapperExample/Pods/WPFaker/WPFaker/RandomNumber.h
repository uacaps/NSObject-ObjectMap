//
//  RandomNumber.h
//  WashPost
//
//  Created by Soper, Sean on 9/23/13.
//  Copyright (c) 2013 Washington Post. All rights reserved.
//

@import Foundation;

/**
 *  A simple class which provides an easy interface for returning random numbers and some related data.
 */
@interface RandomNumber : NSObject

/**
 *  Returns a random integer between two given integers.
 *
 *  @param low  The minimum value.
 *  @param high The maximum value.
 *
 *  @return A random integer between the low and high values, returned as an NSNumber.
 */
- (NSNumber *) inRange:(NSUInteger) low
                  high:(NSUInteger) high;

/**
 *  Returns a random numeric tweet ID, between 80000000-90000000.
 *
 *  @return a random numeric tweet ID, as a string.
 */
- (NSString *) twitterIdStr;

/**
 *  Returns true or false, randomly
 *
 *  @return Either true or false;
 */
- (NSNumber *) trueOrFalse;

@end

//
//  WPFaker.h
//  Rainbow
//
//  Created by Soper, Sean on 10/29/14.
//  Copyright (c) 2014 Washington Post. All rights reserved.
//

@import Foundation;

#import <MBFaker/MBFaker.h>
#import "RandomNumber.h"
#import "Dates.h"

/**
 *  The MBFakerInternet(WP) category defines some additional helper methods on the MBFakerInternet class.
 *
 *  @see path
 *  @see uuid
 */
@interface MBFakerInternet (WP)

/**
 *  Generates a random, valid file path string.
 *  
 *  Examples:
 *
 *      /lauretta/delores.barton/arjun/leopold/margarette.hamill
 *      /beverly.witting/elwin.hackett/theo/hilma.wunsch/elsie
 *      /lauretta/delores.barton/arjun/leopold/margarette.hamill
 *
 *  @return A fake file path.
 */
+ (NSString *) path;

/**
 *  Returns a random, valid uuid string.
 *
 *  Examples:
 *
 *      3B4E395F-0C7B-422C-8D6B-03ED15FCCD69
 *      1157F127-6246-4F4C-B070-87E5314F25BF
 *      EE3651FF-048F-442A-8076-4ACB9E3A3FF7
 *
 *  @return A fake UUID.
 */
+ (NSString *) uuid;

@end
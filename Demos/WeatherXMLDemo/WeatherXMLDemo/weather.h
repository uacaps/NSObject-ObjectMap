//
//  weather.h
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "current_condition.h"

@interface weather : current_condition

@property (nonatomic, retain) NSDate *date;

@end

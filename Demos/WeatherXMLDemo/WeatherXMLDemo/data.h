//
//  data.h
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "current_condition.h"
#import "weather.h"
#import "request.h"

@interface data : NSObject

@property (nonatomic, retain) request *request;
@property (nonatomic, retain) weather *weather;
@property (nonatomic, retain) current_condition *current_condition;

@end

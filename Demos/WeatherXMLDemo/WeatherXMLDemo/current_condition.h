//
//  current_condition.h
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface current_condition : NSObject

@property (nonatomic, retain) NSString *observation_time;
@property (nonatomic, retain) NSString *temp_C;
@property (nonatomic, retain) NSString *temp_F;
@property (nonatomic, retain) NSString *weatherCode;
@property (nonatomic, retain) NSString *weatherIconUrl;
@property (nonatomic, retain) NSString *weatherDesc;
@property (nonatomic, retain) NSString *windspeedMiles;
@property (nonatomic, retain) NSString *windspeedKmph;
@property (nonatomic, retain) NSString *winddirDegree;
@property (nonatomic, retain) NSString *winddir16Point;
@property (nonatomic, retain) NSString *precipMM;
@property (nonatomic, retain) NSString *humidity;
@property (nonatomic, retain) NSString *visibility;
@property (nonatomic, retain) NSString *pressure;
@property (nonatomic, retain) NSString *cloudcover;

@end

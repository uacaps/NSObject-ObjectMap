//
//  WebService.h
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "data.h"

@interface WebService : NSObject
// Blocks
typedef void (^RequestSuccess)(data *weatherData);
typedef void (^RequestFailure)();

// Properties
@property (nonatomic, retain) NSOperationQueue *WeatherQueue;

// Methods
-(void)getWeatherDataForSearchTerm:(NSString *)searchTerm success:(RequestSuccess)sBlock failure:(RequestFailure)fBlock;

@end



@interface WeatherOperation : NSOperation
@property (nonatomic, retain) NSData *responseData;
@property (nonatomic, retain) NSURLRequest *request;
-(void)setRequestWithSearch:(NSString *)searchTerm completion:(void (^)(void))block;
@end

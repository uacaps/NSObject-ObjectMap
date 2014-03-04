//
//  WebService.m
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import "WebService.h"
#import "NSObject+ObjectMap.h"

#warning Need to fill in APIKEY! - Remove this line when you've done so!
#define API_KEY @"API-KEY-HERE!"

@implementation WebService

-(id)init {
    if (self = [super init]) {
        self.WeatherQueue = [[NSOperationQueue alloc] init];
        [self.WeatherQueue setMaxConcurrentOperationCount:5];
    }
    return self;
}

-(void)getWeatherDataForSearchTerm:(NSString *)searchTerm success:(RequestSuccess)sBlock failure:(RequestFailure)fBlock {
    WeatherOperation *operation = [[WeatherOperation alloc] init];
    __weak WeatherOperation *weakOp = operation;
    [operation setRequestWithSearch:searchTerm completion:^{
        if (weakOp.responseData) {
            data *weatherData = [[data alloc] initWithXMLData:weakOp.responseData];
            if (weatherData) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    sBlock(weatherData);
                });
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    fBlock();
                });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                fBlock();
            });
        }
    }];
    [self.WeatherQueue addOperation:operation];
}

@end



@implementation WeatherOperation

-(void)setRequestWithSearch:(NSString *)searchTerm completion:(void (^)(void))block {
    searchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    self.request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v1/weather.ashx?q=%@&format=xml&num_of_days=1&key=%@", searchTerm, API_KEY]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    self.completionBlock = block;
}

-(void)main {
    NSError *error;
    NSHTTPURLResponse *response;
    self.responseData = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&error];
}

@end

//
//  PlacesWebservice.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePlacesWebservice.h"
//#import "Helpers.h"

#import "NSObject+ObjectMap.h"

#import "GPOperation.h"

@implementation GooglePlacesWebservice
@synthesize delegate;

-(id)init{
    if (self = [super init]) {
        self.ServiceQueue = [[NSOperationQueue alloc] init];
        [self.ServiceQueue setMaxConcurrentOperationCount:8];
        return self;
    }
    
    return nil;
}

-(void)placesForSearchString:(NSString *)searchString coordinate:(CLLocationCoordinate2D)coordinate radius:(NSInteger)radius{
    
    NSString *urlString = [NSString stringWithFormat:@"maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&sensor=true&keyword=%@&key=%@", coordinate.latitude, coordinate.longitude, radius, [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"], API_KEY];
    
    // Create operation
    GPOperation *operation = [[GPOperation alloc] init];
    __weak GPOperation *weakOperation = operation;
    [operation setMethodPath:urlString data:nil completion:^{
        if (weakOperation.responseData) {
            NSString *responseString = [[NSString alloc] initWithData:weakOperation.responseData encoding:NSUTF8StringEncoding];
            
            if (self.Logging) {
                NSLog(@"%@", responseString);
            }
            
            //Deserialize data into dictionary
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            
            //*********************************
            //* Object Mapping occurs here! ***
            //*********************************
            GooglePlacesResponse *response = [NSObject objectOfClass:@"GooglePlacesResponse" fromJSON:dict];
            //*********************************
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate didFetchPlaces:response];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate didFetchPlaces:nil];
            });
        }
    }];
    [self.ServiceQueue addOperation:operation];
    
}

@end

//  Copyright (c) 2012 The Board of Trustees of The University of Alabama
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. Neither the name of the University nor the names of the contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
//  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//  OF THE POSSIBILITY OF SUCH DAMAGE.

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

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


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "GooglePlacesResponse.h"
#import "GooglePlaceDetailsResponse.h"

#define BASE_API_ADDRESS @"https://maps.googleapis.com/"

#error "Please fill in your Google Places API key and delete this message."
#define API_KEY @""

#define PLACES_NEAR_ME_RADIUS 5000

@protocol GooglePlacesWebserviceDelegate
@optional
-(void)didFetchPlaces:(GooglePlacesResponse *)response;
@end

@interface GooglePlacesWebservice : NSObject {
    
}

//A flag you can set to log out request/response
@property (nonatomic, assign) BOOL Logging;

//The operation queue we will use to make the web call
@property (nonatomic, retain) NSOperationQueue *ServiceQueue;

// Delegate
@property (weak) id <GooglePlacesWebserviceDelegate> delegate;

//Main search method
-(void)placesForSearchString:(NSString *)searchString coordinate:(CLLocationCoordinate2D)coordinate radius:(NSInteger)radius;

@end

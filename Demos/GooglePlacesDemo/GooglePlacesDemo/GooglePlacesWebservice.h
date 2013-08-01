//
//  PlacesWebservice.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

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

//
//  GoogleDetailsResponse.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlaceDetails.h"
#import "NSObject+ObjectMap.h"

@interface GooglePlaceDetailsResponse : NSObject
@property (nonatomic, retain) NSArray *html_attributions;
@property (nonatomic, retain) GooglePlaceDetails *result;
@property (nonatomic, retain) NSString *status;
@end

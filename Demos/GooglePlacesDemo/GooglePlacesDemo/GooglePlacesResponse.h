//
//  GooglePlacesResponse.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

@interface GooglePlacesResponse : NSObject
@property (nonatomic, retain) NSArray *html_attributions;
@property (nonatomic, retain) NSArray *results;
@property (nonatomic, retain) NSString *next_page_token;
@property (nonatomic, retain) NSString *status;
@end

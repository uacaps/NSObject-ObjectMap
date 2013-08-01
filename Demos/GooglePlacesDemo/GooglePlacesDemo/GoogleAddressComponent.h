//
//  GoogleAddressComponent.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePlace.h"
#import "NSObject+ObjectMap.h"

@interface GoogleAddressComponent : NSObject
@property (nonatomic, retain) NSString *long_name;
@property (nonatomic, retain) NSString *short_name;
@property (nonatomic, retain) NSArray *types;
@end

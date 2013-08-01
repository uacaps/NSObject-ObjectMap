//
//  GoogleGeometry.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleLocation.h"
#import "GoogleViewport.h"
@interface GoogleGeometry : NSObject
@property (nonatomic, retain) GoogleLocation *location;
@property (nonatomic, retain) GoogleViewport *viewport;
@end

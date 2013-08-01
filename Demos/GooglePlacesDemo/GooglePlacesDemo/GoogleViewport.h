//
//  GoogleViewport.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleViewportBound.h"

@interface GoogleViewport : NSObject
@property (nonatomic, retain) GoogleViewportBound *northeast;
@property (nonatomic, retain) GoogleViewportBound *southwest;

@end

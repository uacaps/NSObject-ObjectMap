//
//  MapAnnotation.m
//  AlaCOPMobile
//
//  Created by Matthew York on 5/29/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- (CLLocationCoordinate2D)coordinate
{
	CLLocationCoordinate2D inCoord;
    inCoord.latitude = self.Latitude;
    inCoord.longitude = self.Longitude;
    return inCoord;
}

- (NSString *)title
{
    return self.Name;
}

// optional
- (NSString *)subtitle
{
    return self.Description;
}

@end

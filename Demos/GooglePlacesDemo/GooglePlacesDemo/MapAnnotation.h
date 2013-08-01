//
//  MapAnnotation.h
//  AlaCOPMobile
//
//  Created by Matthew York on 5/29/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, retain) UIImage *LeftImage;
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *Description;
@property (nonatomic, assign) double Latitude;
@property (nonatomic, assign) double Longitude;
@property (nonatomic, assign) NSInteger contentIndex;

@end

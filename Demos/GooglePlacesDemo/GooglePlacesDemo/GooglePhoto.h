//
//  GooglePhoto.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

@interface GooglePhoto : NSObject
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) NSNumber *width;
@property (nonatomic, retain) NSArray *html_attributions;
@property (nonatomic, retain) NSString *photo_reference;
@end

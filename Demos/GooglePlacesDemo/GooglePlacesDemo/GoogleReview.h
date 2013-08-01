//
//  GoogleReview.h
//  AlaCOPMobile
//
//  Created by Matthew York on 6/5/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

@interface GoogleReview : NSObject
@property (nonatomic, retain) NSArray *aspects;
@property (nonatomic, retain) NSString *author_name;
@property (nonatomic, retain) NSString *author_url;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSNumber *time;
@end

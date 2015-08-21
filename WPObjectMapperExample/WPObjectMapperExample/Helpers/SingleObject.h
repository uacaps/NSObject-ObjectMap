//
//  SingleObject.h
//  ObjectMapTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleObject : NSObject

@property (nonatomic, retain) NSString *testString;
@property (nonatomic, retain) NSNumber *testBoolean;
@property (nonatomic, retain) NSNumber *testNumber;
@property (nonatomic, retain) NSDate *testDate;
@property (nonatomic, retain) NSDictionary *testDict;

+(SingleObject *)newSingleObject;
- (NSString *)jsonStringWithExtraParameters;

@end

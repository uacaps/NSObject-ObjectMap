//
//  TestObject.h
//  MapTest
//
//  Created by Matt York on 8/8/13.
//  Copyright (c) 2013 Matt York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

@interface TestObject : NSObject
@property (nonatomic, retain) NSString *TestString;
@property (nonatomic, retain) NSString *TestString2;
@property (nonatomic, retain) TestObject *TestObject;
@end

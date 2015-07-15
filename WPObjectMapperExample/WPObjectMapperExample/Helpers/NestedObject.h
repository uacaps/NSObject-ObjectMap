//
//  NestedObject.h
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleObject.h"

@interface NestedObject : NSObject

@property (nonatomic, retain) SingleObject *singleObject;

+ (NestedObject *)newNestedObject;

@end

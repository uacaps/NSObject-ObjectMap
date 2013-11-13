//
//  ObjectWithArray.h
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleObject.h"
#import "NestedObject.h"

@interface ObjectWithSingleObjectsArray : NSObject

@property (nonatomic, retain) NSArray *arrayOfObjects;

+ (ObjectWithSingleObjectsArray *)newObjectWithArrayOfSingleObjects;

@end

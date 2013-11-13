//
//  ObjectWithNestedObjectsArray.h
//  UnitTests
//
//  Created by Matthew York on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectWithNestedObjectsArray : NSObject

@property (nonatomic, retain) NSArray *arrayOfObjects;

+(ObjectWithNestedObjectsArray *)newObjectWithArrayOfNestedObjects;

@end

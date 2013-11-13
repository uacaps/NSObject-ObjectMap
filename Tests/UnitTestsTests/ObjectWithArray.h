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

typedef NS_ENUM(NSInteger, InsideObjectType) {
    InsideObjectTypeSingle,
    InsideObjectTypeNested
};

@interface ObjectWithArray : NSObject

@property (nonatomic, retain) NSArray *arrayOfObjects;

- (instancetype)initWithInsideObjectType:(InsideObjectType)type;

+ (ObjectWithArray *)newObjectWithArrayOfSingleObjects;
+ (ObjectWithArray *)newObjectWithArrayOfNestedObjects;

@end

//
//  TestHelpers.h
//  UnitTests
//
//  Created by Ben Gordon on 11/13/13.
//  Copyright (c) 2013 Center for Advanced Public Safety. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DataType) {
    DataTypeXML,
    DataTypeJSON,
    DataTypeSOAP
};

@interface TestHelpers : NSObject

+ (void)testObject:(id)obj withDeserializedVersion:(id)deserializedObj forMethodNamed:(NSString *)methodName dataType:(DataType)type;

@end

//
//  NSObject+AutoDescription.m
//  WashPost
//
//  Created by Soper, Sean on 2/26/14.
//  Copyright (c) 2014 Washington Post. All rights reserved.
//

#import "NSObject+AutoDescription.h"
#import <objc/runtime.h>

@implementation NSObject (AutoDescription)

- (NSString *) autoDescriptionForClassType:(Class)classType
                         excludeProperties:(NSArray *) properties {
    
	NSMutableString * result = [NSMutableString string];
    
	// Find Out something about super Classes
	Class superClass  = class_getSuperclass(classType);
	if  ( superClass != nil && ![superClass isEqual:[NSObject class]])
	{
		// Append all the super class's properties to the result (Reqursive, until NSObject)
		[result appendString:[self autoDescriptionForClassType:superClass excludeProperties: properties]];
	}
    
	// Add Information about Current Properties
	unsigned int      property_count;
	objc_property_t * property_list = class_copyPropertyList(classType, &property_count); // Must Free, later
    
	for (int i = property_count - 1; i >= 0; --i) { // Reverse order, to get Properties in order they were defined
		objc_property_t property = property_list[i];
        
		// For each property we are loading its name
		const char * property_name = property_getName(property);
		NSString * propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];

        BOOL respondsToProperty = [classType instancesRespondToSelector:NSSelectorFromString(propertyName)];

        // And if name is ok, we are getting value using KVC
        if (propertyName
        && respondsToProperty
        && ![properties containsObject: propertyName]
        && ![propertyName isEqualToString:@"debugDescription"]
        && ![propertyName isEqualToString:@"autoDescription"]
        && ![propertyName isEqualToString:@"description"]) {

			id value = [self valueForKey:propertyName];

			// Format of result items: p1 = v1; p2 = v2; ...
			[result appendFormat:@"%@ = %@;\r      ", propertyName, value];
		}
	}
	free(property_list);//Clean up
    
	return result;
}

- (NSString *) autoDescriptionForClassType:(Class)classType {
    return [self autoDescriptionForClassType: classType excludeProperties: nil];
}

// Reflects about self.
- (NSString *) autoDescription {
	return [NSString stringWithFormat:@"{\r      %@\r      %@}", NSStringFromClass([self class]), [self autoDescriptionForClassType:[self class] excludeProperties: nil]];
}

- (NSString *) autoDescriptionExcluding:(NSArray *) properties {
	return [NSString stringWithFormat:@"{\r      %@\r      %@}", NSStringFromClass([self class]), [self autoDescriptionForClassType:[self class] excludeProperties: properties]];
}

@end

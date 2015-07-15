//
//  NSObject+AutoDescription.h
//  WashPost
//
//  Created by Soper, Sean on 2/26/14.
//  Copyright (c) 2014 Washington Post. All rights reserved.
//

@import Foundation;

@interface NSObject (AutoDescription)

- (NSString *) autoDescription;
- (NSString *) autoDescriptionExcluding:(NSArray *) properties;

@end

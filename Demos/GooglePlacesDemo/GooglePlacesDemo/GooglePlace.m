//
//  GooglePlace.m
//  AlaCOPMobile
//
//  Created by Matthew York on 6/4/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"NSString" forKeyPath:@"propertyArrayMap.types"];
        [self setValue:@"GooglePhoto" forKeyPath:@"propertyArrayMap.photos"];
    }
    return self;
}

-(NSMutableString *)typesString{
    NSMutableString *typesString = [[NSMutableString alloc] initWithString:@""];
    
    for (int ii = 0; ii < self.types.count; ii++) {
        [typesString appendString:self.types[ii]];
        if (ii != self.types.count-1) {
            [typesString appendString:@", "];
        }
    }
    
    return typesString;
}
@end

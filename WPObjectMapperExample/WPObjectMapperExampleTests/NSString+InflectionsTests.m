//
//  NSString+InflectionsTests.m
//  WPObjectMapperExample
//
//  Created by Orcutt, Tyler on 7/15/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Inflections.h"

@interface NSStringInflectionsTests : XCTestCase
@end

@implementation NSStringInflectionsTests

- (void) testUnderScore{
    NSString * str = @"theQuickBrownFoxJumpedOverTheLazyDog";
    NSString *underScore = [str underscore];
    XCTAssertEqualObjects(underScore,@"the_quick_brown_fox_jumped_over_the_lazy_dog");
}

- (void) testCamelCase {
    NSString *str =@"the_quick_brown_fox_jumped_over_the_lazy_dog";
    NSString *camelCase = [str camelcase];
    XCTAssertEqualObjects(camelCase, @"theQuickBrownFoxJumpedOverTheLazyDog");
}

- (void) testClasify {
    NSString *str =@"the_quick_brown_fox_jumped_over_the_lazy_dog";
    NSString *clasify = [str classify];
    XCTAssertEqualObjects(clasify, @"TheQuickBrownFoxJumpedOverTheLazyDog");
}
@end
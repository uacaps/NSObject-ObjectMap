//
//  NSObject-AutoDescriptionTests.m
//  WPObjectMapperExample
//
//  Created by Sean Soper on 6/26/15.
//  Copyright (c) 2015 The Washington Post. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <WPFaker/WPFaker.h>
#import <WPObjectMapper/NSObject+AutoDescription.h>

@interface TestObject : NSObject
@property (nonatomic, strong) NSString *name;
@end

@implementation TestObject
@end

@interface NSObject (AutoDescriptionSpec)
- (NSString *) autoDescriptionForClassType:(Class)classType;
@end

@interface NSObject_AutoDescriptionTests : XCTestCase

@end

@implementation NSObject_AutoDescriptionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProperty {
    TestObject *testObject = [[TestObject alloc] init];
    testObject.name = [MBFakerName name];
    XCTAssertTrue([[testObject autoDescription] containsString: testObject.name]);
    XCTAssertTrue([[testObject autoDescription] containsString: @"name = "]);
}

- (void)testReturnsString {
    TestObject *testObject = [[TestObject alloc] init];
    testObject.name = [MBFakerName name];
    XCTAssertNotNil([testObject autoDescription]);
    XCTAssertTrue([[testObject autoDescription] isKindOfClass: [NSString class]]);
}

@end

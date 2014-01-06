//
//  ViewController.m
//  MapTest
//
//  Created by Matt York on 8/8/13.
//  Copyright (c) 2013 Matt York. All rights reserved.
//

#import "ViewController.h"
#import "TestObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //A sample XML string
    NSString *xmlString = @"<?xml version=\"1.0\"?><TestObject><TestString2 /><TestString>asdf</TestString><TestObject><TestString2 /><TestString>asdf</TestString></TestObject></TestObject></xml>";
    
    //Parse back object
    TestObject *object = [[TestObject alloc] init];
    object = [[TestObject alloc] initWithXMLData:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Print out results
    NSLog(@"Test String: %@", object.TestString);
    NSLog(@"Test String2: %@", object.TestString2);
    NSLog(@"Nested Object Test String: %@", object.TestObject.TestString);
    NSLog(@"Nested Object Test String2: %@", object.TestObject.TestString2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end

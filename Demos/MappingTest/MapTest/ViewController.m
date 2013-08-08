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
    
    NSString *xmlString = @"<?xml version=\"1.0\"?><TestObject><TestString2 /><TestString>asdf</TestString></TestObject></xml>";
    
    TestObject *object = [[TestObject alloc] init];
    object = [NSObject objectOfClass:@"TestObject" fromXML:xmlString];
    NSLog(@"Test String: %@", object.TestString);
    NSLog(@"Test String2: %@", object.TestString2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end

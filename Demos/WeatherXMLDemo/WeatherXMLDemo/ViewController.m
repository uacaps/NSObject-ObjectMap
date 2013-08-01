//
//  ViewController.m
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.Service = [[WebService alloc] init];
    self.cityZipLabel.text = @"";
    self.tempLabel.text = @"";
    self.itIsCurrentlyLabel.alpha = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self makeWeatherRequest];
    return YES;
}

-(void)makeWeatherRequest {
    [self.Service getWeatherDataForSearchTerm:self.cityZipTextField.text success:^(data *weatherData){
        self.cityZipLabel.text = weatherData.request.query;
        self.tempLabel.text = weatherData.current_condition.temp_F;
        self.itIsCurrentlyLabel.alpha = 1;
    } failure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Either the internet doesn't work, or your search terms failed to yield results. Try again." delegate:nil cancelButtonTitle:@"Got it." otherButtonTitles:nil];
        [alert show];
    }];
}



@end

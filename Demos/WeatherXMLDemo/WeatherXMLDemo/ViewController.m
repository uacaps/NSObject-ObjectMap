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
    self.precipitationLabel.alpha = 0;
    self.humidityLabel.alpha = 0;
    self.visibilityLabel.alpha = 0;
    self.windSpeedLabel.alpha = 0;
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
        self.tempLabel.text = [NSString stringWithFormat:@"%@˚ F", weatherData.current_condition.temp_F];
        self.windSpeedLabel.text = [NSString stringWithFormat:@"Wind Speed: %@, %@ mph", weatherData.current_condition.winddir16Point, weatherData.current_condition.windspeedMiles];
        self.precipitationLabel.text = [NSString stringWithFormat:@"Precipitation: %@mm", weatherData.current_condition.precipMM];
        self.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %@", weatherData.current_condition.humidity];
        self.visibilityLabel.text = [NSString stringWithFormat:@"Visibility: %@mm", weatherData.current_condition.visibility];
        
        self.precipitationLabel.alpha = 1;
        self.humidityLabel.alpha = 1;
        self.visibilityLabel.alpha = 1;
        self.windSpeedLabel.alpha = 1;
        self.itIsCurrentlyLabel.alpha = 1;
    } failure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Either the internet doesn't work, or your search terms failed to yield results. Try again." delegate:nil cancelButtonTitle:@"Got it." otherButtonTitles:nil];
        [alert show];
    }];
}



@end

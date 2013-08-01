//
//  ViewController.h
//  WeatherXMLDemo
//
//  Created by Benjamin Gordon on 8/1/13.
//  Copyright (c) 2013 CAPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"

@interface ViewController : UIViewController<UITextFieldDelegate>

// WebService
@property (nonatomic, retain) WebService *Service;

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *cityZipLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityZipTextField;
@property (weak, nonatomic) IBOutlet UILabel *itIsCurrentlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipitationLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;

@end

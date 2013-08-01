//
//  ViewController.h
//  GooglePlacesDemo
//
//  Created by Matt York on 7/17/13.
//  Copyright (c) 2013 Matt York. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlacesWebservice.h"
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <GooglePlacesWebserviceDelegate, UITextFieldDelegate, MKMapViewDelegate> {
    
    __weak IBOutlet MKMapView *MapView;
    __weak IBOutlet UITextField *SearchTextField;
    NSArray *PlacesArray;
}

@end

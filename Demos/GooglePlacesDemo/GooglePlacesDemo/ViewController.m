//  Copyright (c) 2012 The Board of Trustees of The University of Alabama
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. Neither the name of the University nor the names of the contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
//  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//  OF THE POSSIBILITY OF SUCH DAMAGE.
#import "ViewController.h"
#import "MapAnnotation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    //Zoom map to Tuscaloosa
    [self zoomMap:MapView toCoordinate:CLLocationCoordinate2DMake(33.219459, -87.542917) withSpan:MKCoordinateSpanMake(0.3, 0.3) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchGoogleWithString:textField.text];
    return YES;
}

#pragma mark - Google Places

-(void)searchGoogleWithString:(NSString *)searchString{
    [SearchTextField resignFirstResponder];
    [MapView removeAnnotations:MapView.annotations];
    
    //Create webservice call
    GooglePlacesWebservice *service = [[GooglePlacesWebservice alloc] init];
    service.delegate = self;
    service.Logging = YES;
    
    //Make the call
    [service placesForSearchString:searchString coordinate:MapView.centerCoordinate radius:15000];
}

-(void)didFetchPlaces:(GooglePlacesResponse *)response{
    if (response) {
        if (response.results.count > 0) {
            PlacesArray = response.results;
            
            [PlacesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self addAnnotation:PlacesArray[idx] contentIndex:idx];
            }];
        }
        
        //Resize window to fit annotations
        [self zoomMapViewForAllAnnotations:MapView];
    }
}

#pragma mark - Annotation Creation

-(void)addAnnotation:(id)annotationData contentIndex:(NSInteger)contentIndex {
    MapAnnotation *ann = [[MapAnnotation alloc] init];
    if ([annotationData isKindOfClass:[GooglePlace class]]){
        GooglePlace *place = (GooglePlace *)annotationData;
        
        ann.Latitude = [place.geometry.location.lat floatValue];
        ann.Longitude = [place.geometry.location.lng floatValue];
        ann.Name = place.name;
        ann.Description = [place typesString];
        ann.contentIndex = contentIndex;
    }
    
    [MapView addAnnotation:ann];
}

#pragma mark - MKMapView Delegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    [SearchTextField resignFirstResponder];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                    reuseIdentifier:nil];
    annotationView.canShowCallout = YES;
    
	UIImage *flagImage = [UIImage imageNamed:@"MapPin@2x.png"];
    
    annotationView.image = flagImage;
    
    float xCenter = annotationView.center.x;
    float yCenter = annotationView.center.y;
    
    annotationView.frame = CGRectMake(0, 0, 35, 35);
    annotationView.center = CGPointMake(xCenter, yCenter);
    
    [annotationView setCanShowCallout:YES];
    
	return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView1 didSelectAnnotationView:(MKAnnotationView *)view{
    MapAnnotation *selectedAnnotation = (MapAnnotation *)view.annotation;
    
}

#pragma mark - Map Zooming

-(void)zoomMap:(MKMapView *)map  toCoordinate:(CLLocationCoordinate2D)coordinate withSpan:(MKCoordinateSpan)span animated:(BOOL)animated{
    
    MKCoordinateRegion region;
    region.span=span;
    region.center=coordinate;
    
    [MapView setRegion:region animated:animated];
    [MapView regionThatFits:region];
}

-(void)zoomMapViewForAllAnnotations:(MKMapView *)aMapView {
    if([aMapView.annotations count] == 0)
        return;
    
    //Establish Max/Min
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    //Iterate over all annotations and find bounds
    for(MKPointAnnotation* annotation in aMapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    //Set region
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 2; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 2; // Add a little extra space on the sides
    
    region = [aMapView regionThatFits:region];
    [aMapView setRegion:region animated:YES];
}


@end

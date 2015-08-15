//
//  GPSViewController.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZettaKit/ZIKDevice.h>
#import <MapKit/MapKit.h>

@interface GPSViewController : UIViewController

@property (nonatomic, retain) ZIKDevice *gps;
@property (nonatomic, retain) ZIKStream *fix;
@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, retain) IBOutlet UILabel *warning;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *indicator;

@end

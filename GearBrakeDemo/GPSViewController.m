//
//  GPSViewController.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "GPSViewController.h"
#import <ZettaKit/ZIKStream.h>
#import <ZettaKit/ZIKStreamEntry.h>
#import <CoreLocation/CoreLocation.h>

@interface GPSViewController () {
    CLLocation *_coordinates;
}



@end

@implementation GPSViewController

-(void)viewDidLoad {
    self.fix = [self.gps stream:@"fix"];
    @weakify(self)
    [self.fix.signal subscribeNext:^(ZIKStreamEntry *x) {
        @strongify(self)
        NSLog(@"%@", x);
        NSString *lat = (NSString *)x.data[@"lat"];
        NSString *lon = (NSString *)x.data[@"lon"];
        if (![lat isEqualToString:@""] && ![lon isEqualToString:@""]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.warning.hidden = YES;
                [self.indicator stopAnimating];
                self.map.hidden = NO;
                _coordinates = [[CLLocation alloc] initWithLatitude:[self convertCoordinateFromString:lat] longitude:[self convertCoordinateFromString:lon]];
                MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_coordinates.coordinate, 500, 500);
                MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];
                [self.map setRegion:adjustedRegion];
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                annotation.coordinate = _coordinates.coordinate;
                annotation.title = @"Point";
                [self.map addAnnotation:annotation];
            });
        }
    }];
    [self.fix resume];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        if (self.fix != nil) {
            [self.fix stop];
        }
    }
    [super viewWillDisappear:animated];
}

- (double) convertCoordinateFromString:(NSString *) stringCoord {
    BOOL isNeg = NO;
    if ([stringCoord hasPrefix:@"0"]) {
        isNeg = YES;
    }
    double coord = [stringCoord doubleValue];
    
    
    double min = 0.0;
    double decDeg = 0.0;
    
    min = fmod(coord, 100.0);
    coord = (int) (coord / 100.0);
    decDeg = coord + (min / 60.0);
    
    if (isNeg) {
        return decDeg * -1;
    } else {
        return decDeg;
    }
}

@end

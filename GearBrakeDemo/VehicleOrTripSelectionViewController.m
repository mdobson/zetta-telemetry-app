//
//  VehicleOrTripSelectionViewController.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "VehicleOrTripSelectionViewController.h"
#import "GPSViewController.h"
#import "OrientationViewController.h"
#import <ZettaKit/ZIKQuery.h>

@interface VehicleOrTripSelectionViewController ()

@end

@implementation VehicleOrTripSelectionViewController

- (void) viewDidLoad {
    ZIKSession *session = [ZIKSession sharedSession];
    NSURL *rootUrl = [NSURL URLWithString:@"http://zetta-telemetry-cloud.herokuapp.com/"];
    self.rootSignal = [session root:rootUrl];
    self.serverSignal = [session servers:self.rootSignal];
    self.deviceSignal = [session devices:self.serverSignal];
    self.gps = nil;
    self.orientation = nil;
    self.bike = nil;
    @weakify(self)
    [self.deviceSignal subscribeNext:^(ZIKDevice *x) {
        NSLog(@"%@", x.type);
        @strongify(self)
        if ([x.type isEqualToString:@"gps"]) {
            self.gps = x;
        } else if ([x.type isEqualToString:@"orientation"]) {
            self.orientation = x;
        } else if ([x.type isEqualToString:@"bike"]) {
            self.bike = x;
            if ([self.bike.state isEqualToString:@"parked"]) {
                [self.bikeControl setTitle:@"Start Ride" forState:UIControlStateNormal];
            } else if ([self.bike.state isEqualToString:@"running"]) {
                [self.bikeControl setTitle:@"Park Bike" forState:UIControlStateNormal];
            }
        }
       
        if (self.gps && self.orientation) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.trip.userInteractionEnabled = YES;
                self.vehicle.userInteractionEnabled = YES;
                [self.indicator stopAnimating];
                
                self.searchLabel.hidden = YES;
                self.trip.hidden = NO;
                self.vehicle.hidden = NO;
            });
        }
        
        if (self.bike) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.bike.state isEqualToString:@"parked"]) {
                    [self.bikeControl setTitle:@"Start Ride" forState:UIControlStateNormal];
                    self.bikeControl.hidden = NO;
                } else if ([self.bike.state isEqualToString:@"running"]) {
                    [self.bikeControl setTitle:@"Park Bike" forState:UIControlStateNormal];
                    self.bikeControl.hidden = NO;
                }
            });
        }
    }];
}

- (IBAction)bikeAction:(id)sender {
    if ([self.bike.state isEqualToString:@"parked"]) {
        [self.bike transition:@"start" andCompletion:^(NSError *err, ZIKDevice *device, NSURLResponse *response) {
            if (err) {
                NSLog(@"Error");
            }
        }];
    } else if([self.bike.state isEqualToString:@"running"]) {
        [self.bike transition:@"park" andCompletion:^(NSError *err, ZIKDevice *device, NSURLResponse *response) {
            if (err) {
                NSLog(@"Error");
            }
        }];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"gps"]) {
        GPSViewController *vc = [segue destinationViewController];
        vc.gps = self.gps;
    } else if ([[segue identifier] isEqualToString:@"orientation"]) {
        OrientationViewController *vc = [segue destinationViewController];
        vc.orientation = self.orientation;
    }
}


@end

//
//  VehicleOrTripSelectionViewController.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ZettaKit/ZIKSession.h>
#import <ZettaKit/ZIKDevice.h>

@interface VehicleOrTripSelectionViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *trip;
@property (nonatomic, retain) IBOutlet UIButton *vehicle;
@property (nonatomic, retain) IBOutlet UIButton *bikeControl;
@property (nonatomic, retain) IBOutlet UILabel *searchLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, retain) RACSignal *rootSignal;
@property (nonatomic, retain) RACSignal *serverSignal;
@property (nonatomic, retain) RACSignal *deviceSignal;
@property (nonatomic, retain) ZIKServer *currentServer;
@property (nonatomic, retain) ZIKDevice *gps;
@property (nonatomic, retain) ZIKDevice *orientation;
@property (nonatomic, retain) ZIKDevice *bike;

- (IBAction)bikeAction:(id)sender;

@end

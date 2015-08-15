//
//  AppDelegate.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/12/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ApigeeiOSSDK/Apigee.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ApigeeClient *apigeeClient; //object for initializing the App Services SDK
@property (strong, nonatomic) ApigeeMonitoringClient *monitoringClient; //client object for Apigee App Monitoring methods
@property (strong, nonatomic) ApigeeDataClient *dataClient; //client object for App Services data methods
@property (strong, nonatomic) ApigeeEntity *user;

@end


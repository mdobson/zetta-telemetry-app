//
//  Util.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "Util.h"
#import "AppDelegate.h"

@implementation Util

+ (ApigeeDataClient *) sharedDataClient {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.dataClient;
}

@end

//
//  OrientationViewController.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZettaKit/ZIKDevice.h>
#import <GLKit/GLKit.h>

@interface OrientationViewController : GLKViewController

@property (nonatomic, retain) ZIKDevice *orientation;
@property (nonatomic, retain) ZIKStream *euler;

@end

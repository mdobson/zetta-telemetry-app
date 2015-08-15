//
//  Util.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/13/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Apigee.h>

@interface Util : NSObject

+ (ApigeeDataClient *) sharedDataClient;

@end

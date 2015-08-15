//
//  AddContactViewController.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/14/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "AddContactViewController.h"
#import "Util.h"
#import "AppDelegate.h"
#import <Apigee.h>

@implementation AddContactViewController

-(IBAction)addContact:(id)sender {
    NSString *name = self.name.text;
    NSString *number = self.number.text;
    BOOL isOwner = self.owner.selected;
    
    ApigeeDataClient *client = [Util sharedDataClient];
    [client createEntity:@{@"type": @"contact",@"name": name, @"number": number, @"bikeOwner": [NSNumber numberWithBool:isOwner]} completionHandler:^(ApigeeClientResponse *response) {
        if (response.completedSuccessfully) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            ApigeeEntity *ent = response.entities[0];
            NSLog(@"%@", response.rawResponse);
            [client connectEntities:@"users" connectorID:@"me" connectionType:@"emergency" connecteeType:@"contacts" connecteeID:(NSString *)[ent get:@"uuid"] completionHandler:^(ApigeeClientResponse *response) {
                NSLog(@"%@", response.rawResponse);
            }];
        }
    }];
    
}

@end

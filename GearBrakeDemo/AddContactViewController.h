//
//  AddContactViewController.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/14/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *number;
@property (nonatomic, retain) IBOutlet UISwitch *owner;

- (IBAction)addContact:(id)sender;

@end

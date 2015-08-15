//
//  ViewController.h
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/12/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;

@end


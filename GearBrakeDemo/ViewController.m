//
//  ViewController.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/12/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "ViewController.h"
#import "Util.h"
#import "AppDelegate.h"
#import <Apigee.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)login:(id)sender {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSLog(@"Logging in with credentials: %@ : %@", username, password);
    ApigeeDataClient *dataClient = [Util sharedDataClient];
    [dataClient logInUser:username password:password completionHandler:^(ApigeeClientResponse *response) {
        if (response.completedSuccessfully) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.user = response.entities[0];
            [self performSegueWithIdentifier:@"options" sender:self];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Try another credential combo." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

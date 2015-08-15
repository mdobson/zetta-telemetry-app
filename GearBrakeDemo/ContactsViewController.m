//
//  ContactsViewController.m
//  GearBrakeDemo
//
//  Created by Matthew Dobson on 8/14/15.
//  Copyright (c) 2015 Matthew Dobson. All rights reserved.
//

#import "ContactsViewController.h"
#import "Util.h"
#import <Apigee.h>

@interface ContactsViewController ()

@property (nonatomic, retain) NSMutableArray *contacts;
@property (nonatomic, retain) ApigeeClientResponse *contactsResponse;

@end

@implementation ContactsViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.contacts = [[NSMutableArray alloc] init];
    ApigeeDataClient *client = [Util sharedDataClient];

    NSLog(@"Here");
    __weak ContactsViewController *vc = self;
    [client getEntityConnections:@"users" connectorID:@"me" connectionType:@"emergency" query:nil completionHandler:^(ApigeeClientResponse *response) {
        for (ApigeeEntity *ent in response.entities) {
            [vc.contacts addObject:ent];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", vc.contacts);
            [vc.tableView reloadData];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ApigeeEntity *ent = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = (NSString *)[ent get:@"number"];
    return cell;
}

-(void) insertNewObject {
    [self performSegueWithIdentifier:@"addContact" sender:self];
}
@end

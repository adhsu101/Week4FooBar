//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AppDelegate.h"
#import "OwnerViewController.h"
#import "DogsViewController.h"
#import "JSONManager.h"
#import "Owner.h"
#import "Dog.h"

@interface OwnerViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property NSManagedObjectContext *moc;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSArray *ownerNames;
@property NSArray *owners;

@end

@implementation OwnerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    self.title = @"Dog Owners";

    [self loadMOC];
    if (self.owners.count == 0)
    {
        self.ownerNames = [JSONManager loadJSON];
        [self addOwnersToDb];
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadMOC];
}


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owners.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];

    Owner *owner = self.owners[indexPath.row];
    cell.textLabel.text = owner.name;

    return cell;
}


#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

}


//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}


#pragma mark - helper methods

- (void)addOwnersToDb
{
    for (NSString *ownerName in self.ownerNames)
    {
        Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Owner class]) inManagedObjectContext:self.moc];
        owner.name = ownerName;
        [self.moc save:nil];
    }

    [self loadMOC];
}


- (void)loadMOC
{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Owner class])];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortByName];

    self.owners = [[self.moc executeFetchRequest:request error:nil] mutableCopy];

    [self.myTableView reloadData];
    
}

#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController *vc = segue.destinationViewController;
    Owner *selectedOwner = self.owners[[self.tableView indexPathForSelectedRow].row];
    vc.owner = selectedOwner;
}

@end

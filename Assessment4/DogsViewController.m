//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "DogTableViewCell.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *dogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
    self.dogs = [self.owner.dogs allObjects];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadMOC];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owner.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];

    Dog *dog = self.dogs[indexPath.row];
    cell.nameLabel.text = dog.name;
    cell.breedLabel.text = dog.breed;
    cell.colorLabel.text = dog.color;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddDogViewController *vc = segue.destinationViewController;

    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        vc.owner = self.owner;
        vc.dog = nil;
    }
    else
    {
        vc.owner = nil;
        vc.dog = self.dogs[[self.dogsTableView indexPathForSelectedRow].row];
    }
}

- (IBAction)unwindFromAddDogVC:(UIStoryboardSegue *)sender
{

}

 - (void)loadMOC
{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Dog class])];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortByName];

    self.dogs = [[self.owner.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];

    [self.dogsTableView reloadData];
    
}

@end

//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "AppDelegate.h"

@interface AddDogViewController ()

@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";
    self.moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];

    if (self.dog)
    {
        self.nameTextField.text = self.dog.name;
        self.breedTextField.text = self.dog.breed;
        self.colorTextField.text = self.dog.color;
    }

}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if (![self.nameTextField.text isEqualToString:@""])
    {
        if (self.owner)
        {
            self.dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.moc];
            [self.owner addDogsObject:self.dog];
        }

        self.dog.name = self.nameTextField.text;
        self.dog.breed = self.breedTextField.text;
        self.dog.color = self.colorTextField.text;

        [self.moc save:nil];

    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end

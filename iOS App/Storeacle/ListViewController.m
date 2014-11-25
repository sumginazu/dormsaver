//
//  ListViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 8/3/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "ListViewController.h"
#import <Parse/Parse.h>
@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor * color = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:1.0f];
    UIColor * color1 = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:0.8f];
    [[self view] setBackgroundColor:color];
    self.navigationController.navigationBar.barTintColor = color1;
    self.navigationItem.hidesBackButton = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signin:(id)sender {
    NSString *name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pass = [self.passField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([name length] == 0 || [pass length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bro," message:@"We need both fields." delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        [PFUser logInWithUsernameInBackground:name password:pass block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Yo," message:@"Something was wrong, dude." delegate:nil cancelButtonTitle:@"Darn" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        
    }
    
}


@end
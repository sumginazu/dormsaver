//
//  RegisterViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 8/3/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
@interface RegisterViewController ()

@end

@implementation RegisterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (IBAction)register:(id)sender {
    NSString *name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pass = [self.passField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([name length] == 0 || [pass length] == 0 || [email length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"We need all three fields." delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        PFUser *newUser = [PFUser user];
        newUser.username = name;
        newUser.password = pass;
        newUser.email = email;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Yo," message:@"Something went wrong." delegate:nil cancelButtonTitle:@"Darn" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
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


@end

//
//  ListViewController.h
//  Beatlet1
//
//  Created by Sudev Bohra on 8/3/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
- (IBAction)signin:(id)sender;

- (IBAction)signout:(id)sender;


@end

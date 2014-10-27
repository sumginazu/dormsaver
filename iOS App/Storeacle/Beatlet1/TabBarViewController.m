//
//  TabBarViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 10/21/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
    UIColor * color = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:0.8f];
    UIColor * pink = [UIColor colorWithRed:255/255.0f green:134/255.0f blue:184/255.0f alpha:1.0f];
    [[UITabBar appearance] setTintColor:pink];
    [[UITabBar appearance] setBarTintColor:color];
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

@end

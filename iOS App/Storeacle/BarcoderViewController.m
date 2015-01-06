//
//  BarcoderViewController.m
//  Beatlet1
//
//  Created by Abdelwahab Bourai on 12/3/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "BarcoderViewController.h"

@interface BarcoderViewController ()

@end

@implementation BarcoderViewController

@synthesize scanButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    UIColor * color = [UIColor colorWithRed:66/255.0f green:66/255.0f blue:66/255.0f alpha:1.0f];
    UIColor * color1 = [UIColor colorWithRed:0.188 green:0.498 blue:0.886 alpha:1]; //*#307fe2*
    [[self view] setBackgroundColor:color];
    self.navigationController.navigationBar.barTintColor = color1;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanButton:(id)sender {
    
    
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

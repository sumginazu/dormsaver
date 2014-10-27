//
//  WatsonViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 10/20/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "WatsonViewController.h"

@interface WatsonViewController ()

@end

@implementation WatsonViewController

@synthesize answerLabel;
@synthesize questionLabel;

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

- (IBAction)askWatson:(id)sender {
    NSString *question = [self.questionLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([question isEqualToString:@"Does the Xbox One have blu-ray?"])
    {
        [self.answerLabel setText:@"""The Blu-ray player app allows you to enjoy your favorite Blu-ray and DVD movies through your Xbox One console.Note When you insert a disc for the first time, you’ll see a prompt to install the player app. For more information, see Set up and install the Blu-ray and DVD player app."""];
    }
    else
    {
        [self.answerLabel setText:@"""Answer not available."""];
    }
}
@end

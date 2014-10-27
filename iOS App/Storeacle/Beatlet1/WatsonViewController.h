//
//  WatsonViewController.h
//  Beatlet1
//
//  Created by Sudev Bohra on 10/20/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatsonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *questionLabel;

- (IBAction)askWatson:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;


@end

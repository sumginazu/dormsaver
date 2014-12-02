//
//  WatsonViewController.h
//  Beatlet1
//
//  Created by Sudev Bohra on 10/20/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>
@import AVFoundation;

@interface OracleViewController : UIViewController <SpeechKitDelegate, SKRecognizerDelegate, SKVocalizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *questionLabel;

@property (weak, nonatomic) IBOutlet UITextView *answerLabel;
- (IBAction)dislikeAction:(id)sender;

@property (retain, nonatomic) NSMutableData *receivedData;

- (IBAction)askWatson:(id)sender;
- (IBAction)recordButtonAction:(id)sender;

@property (readonly) SKRecognizer* voiceSearch;
@property (weak, nonatomic) IBOutlet UIImageView *recordIcon;
@property (weak, nonatomic) UIImage* recording;
@property (weak, nonatomic) UIImage* notRecording;
@property (weak, nonatomic) UIImage* playing;
@property (strong, nonatomic) SKVocalizer* vocalizer;
@property (weak, nonatomic) NSString* status;
@end

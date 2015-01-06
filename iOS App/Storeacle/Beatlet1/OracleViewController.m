//
//  WatsonViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 10/20/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "OracleViewController.h"
#import "GCDAsyncSocket.h"


const unsigned char SpeechKitApplicationKey[] =
{
    0x2f, 0x1a, 0x39, 0x6e, 0x56, 0x9b, 0x2c, 0x24, 0x09, 0x94, 0xe7, 0x35, 0x3a, 0x99, 0x90, 0xa2, 0x25, 0xc2, 0x1d, 0x7e, 0x9a, 0x7b, 0x1c, 0xd8, 0xe3, 0x6f, 0x1d, 0xdd, 0x3c, 0x32, 0x7c, 0x6c, 0x4d, 0xb5, 0xda, 0xa3, 0x50, 0x06 ,0xc7, 0x59, 0x9a, 0xaf, 0x8f, 0xd4, 0x48, 0x1f, 0x76, 0x6d, 0xe2, 0x93, 0xeb, 0x7c, 0x0e, 0x07 ,0x54 ,0xf1, 0x77 ,0x72, 0xcf, 0xb3, 0xa4, 0x4b, 0x1f, 0xf1
};



@interface OracleViewController ()
@end

@implementation OracleViewController

@synthesize answerLabel,vocalizer, playing, questionLabel, voiceSearch, recordIcon, recording, notRecording;


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
    self.questionLabel.delegate = self;
    UIColor * color = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    UIColor * color1 = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:0.8f];
    [[self view] setBackgroundColor:color];
    self.navigationController.navigationBar.barTintColor = color;
    
    [SpeechKit setupWithID:@"NMDPTRIAL_sudevbohra20141022032301"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:nil];
    
    notRecording = [UIImage imageNamed: @"record.png"];
    playing = [UIImage imageNamed: @"stop.png"];
    status = @"record";
    vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor colorWithRed:1 green:0.4 blue:0.2 alpha:1] forKey:UITextAttributeTextColor]];
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
NSMutableData *mutData;

- (IBAction)dislikeAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for disliking"
                                                    message:@"Now, I can get better at answering your questions."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (BOOL)containHelper:(NSString*)sentence words:(NSArray*) words
{
    for (NSString* word in words) {
        if (![sentence containsString:word]){
            return NO;
        }
    }
    return YES;
}

- (IBAction)askWatson:(id)sender {
    NSString *question = [self.questionLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //SKVocalizer* vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
    if (![@"Oracle" isEqual:[self.navigationItem title]])
    {
        if ([question containsString:@" its "])
        {
            question = [question stringByReplacingOccurrencesOfString:@"its"
                                                           withString:[NSString stringWithFormat:@"%@/%@/", @"the ", [self.navigationItem title]]];
        }
        else if ([question containsString:@" it "])
        {
            question = [question stringByReplacingOccurrencesOfString:@"it"
                                                           withString:[NSString stringWithFormat:@"%@/%@/", @"the ", [self.navigationItem title]]];
        }
        
    }
    
    if ([self containHelper:[question lowercaseString] words:[NSArray arrayWithObjects:@"blu-ray", @"xbox one",nil]])
    {
        NSString* tx = @"""The Blu-ray player app allows you to enjoy your favorite Blu-ray and DVD movies through your Xbox One console.Note When you insert a disc for the first time, you’ll see a prompt to install the player app. For more information, see Set up and install the Blu-ray and DVD player app.""";
        [self.navigationItem setTitle:@"Xbox One"];
        [vocalizer speakString:tx];
        [self.answerLabel setText:tx];
    }
    else if ([self containHelper:[question lowercaseString] words:[NSArray arrayWithObjects:@"iphone",@"screen",nil]])
    {
        NSString* tx = @"From specification, the screen size of the iPhone 6 is 4.7 in (120 mm) 1334x750 pixel resolution, 326 ppi pixel density, 1400:1 contrast ratio (typical).";
        [self.navigationItem setTitle:@"Samsung Galaxy S5"];
        [vocalizer speakString:tx];
        [self.answerLabel setText:tx];
    }
    else if ([self containHelper:[question lowercaseString] words:[NSArray arrayWithObjects:@"samsung", @"galaxy",@"weight",nil]])
    {
        NSString* tx = @"From specification, the weight of the Samsung Galaxy S5 is 145 g (5.11 oz).";
        [self.navigationItem setTitle:@"Samsung Galaxy S5"];
        [vocalizer speakString:tx];
        [self.answerLabel setText:tx];
    }
    else if ([self containHelper:[question lowercaseString] words:[NSArray arrayWithObjects:@"samsung", @"galaxy",@"water",nil]]){
        NSString* tx = @"""The Galaxy S5's water resistance works just as it does on other recent water resistant phones. There are rubber seals on the plastic cover and on the flap that sits over the USB port on the bottom.""";
        [self.navigationItem setTitle:@"Samsung Galaxy S5"];
        [vocalizer speakString:tx];
        [self.answerLabel setText:tx];
    }
    else if([self containHelper:[question lowercaseString] words:[NSArray arrayWithObjects:@"samsung", @"galaxy",@"compare",@"iphone", nil]])
    {
        NSString* tx = @"""The iPhone 6 is closer than ever to the Samsung Galaxy S5. Where once there was a huge difference in screen size now there's just 0.4-inches. In terms of size and design though the iPhone 6 is way ahead of the S5. Made of brushed aluminium it's just 6.9mm thick compared to the 8.1 of the Galaxy S5 and feels a whole lot more premium in hand. Touch ID is also a lot easier to use than the fingerprint scanner on the S5. If you like phones you can easily use one-handed then the iPhone 6 wins out. iOS 8 is also a big step up and is a slicker experience than the TouchWiz heavy interface on the S5. The Samsung is more customisable but the iPhone is smoother and easier to use. That's where the benefits of the iPhone 6 end. The Galaxy S5 may not feel as premium but it it water resistant, has an outstanding screen (if you choose the right settings) and battery life that stands head and shoulders above Apple's phone. Add to that a microSD slot for cheap extra storage, removable battery and a camera that in some cases exceeds the solid snapper on the iPhone 6 and the Galaxy S5 becomes a compelling proposition. That's before you even factor in that it's now a lot cheaper.""";
        [self.navigationItem setTitle:@"iPhone 6"];
        [vocalizer speakString:tx];
        [self.answerLabel setText:tx];
    }

    else
    {
        NSString *host = @"localhost";
        int port = 3001;
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)(host), port, &readStream, &writeStream);
        //[NSThread sleepForTimeInterval:2]; //Delay
        
        
        CFWriteStreamSetProperty(writeStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
        if(!CFWriteStreamOpen(writeStream))
        {
            NSLog(@"Error Opening Socket");
        }
        else
        {
            //char *result;
            //result = [question UTF8String];
            UInt8 *buf = (UInt8 *)[question UTF8String];
            int bytesWritten = CFWriteStreamWrite(writeStream, buf, strlen((char*)buf));
            NSLog(@"Written: %d", bytesWritten);
        }

        [NSThread sleepForTimeInterval:3];
        NSString *filepath = @"Users/sudevbohra/Documents/dormsaver/answer.txt";

        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
        
        if (error)
            NSLog(@"Error reading file: %@", error.localizedDescription);
        
        UIColor * whiteColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];

        
        NSString *contextpath = @"Users/sudevbohra/Documents/dormsaver/context.txt";
        NSString *context = [NSString stringWithContentsOfFile:contextpath encoding:NSUTF8StringEncoding error:&error];
        NSString* tx = fileContents;
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
        self.navigationController.navigationBar.topItem.title = context;
    }
}
- (IBAction)recordButtonAction:(id)sender {
    recording = [UIImage imageNamed: @"record1.png"];
    
    if ([status isEqual: @"stop"]){
        [recordIcon setImage:recording];
        status = @"record1";
        [vocalizer cancel];
    }
    else if ([status  isEqual: @"record"]) {
        [recordIcon setImage:recording];
        status = @"record1";
        NSString* recoType = SKSearchRecognizerType;
        NSString* langType = @"en_US";
        SKEndOfSpeechDetection detectionType = SKLongEndOfSpeechDetection;
        
        voiceSearch = [[SKRecognizer alloc] initWithType:recoType
                                               detection:detectionType
                                                language:langType
                                                delegate:self];
    }
    else if ([status  isEqual: @"record1"]){
        [voiceSearch stopRecording];
        [questionLabel setText:@""];
        
    }
}
- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results
{
    //questionLabel.text = @"finished";
    notRecording = [UIImage imageNamed: @"record.png"];
    status = @"record";
    [recordIcon setImage:notRecording];
    long numOfResults = [results.results count];
    if (numOfResults > 0)
    {
        questionLabel.text = [results firstResult];
        //[self askWatson:0];
        
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [mutData setLength:0];
    NSLog(@"Response Successful!");
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    questionLabel.text = @"Error Recognizing.";
    questionLabel.text = suggestion;
}

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    questionLabel.text = @"Processing...";
    
    //status = @"Recording";
    
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    //questionLabel.text = @"finished";
    notRecording = [UIImage imageNamed: @"record.png"];
    [recordIcon setImage:notRecording];
    status = @"record";
}

- (void)vocalizer:(SKVocalizer *)vocalizer didFinishSpeakingString:(NSString *)text withError:(NSError *)error
{
    recording = [UIImage imageNamed: @"record.png"];
    [recordIcon setImage:recording];
    status = @"record";
    
}

- (void)vocalizer:(SKVocalizer *)vocalizer willBeginSpeakingString:(NSString *)text
{
    playing = [UIImage imageNamed: @"stop.png"];
    [recordIcon setImage:playing];
    status = @"stop";
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [mutData appendData:data];
    NSLog(@"Response Successful!");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


/*
 if data is successfully received, this method will be called by connection
 */
/*- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[mutData length]);
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    connection = nil;
    mutData = nil;
}*/

@end

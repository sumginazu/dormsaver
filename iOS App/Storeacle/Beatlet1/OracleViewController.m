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

@synthesize answerLabel,vocalizer, playing;
@synthesize questionLabel, voiceSearch, recordIcon, recording, notRecording, status;

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
    
    [SpeechKit setupWithID:@"NMDPTRIAL_sudevbohra20141022032301"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:self];
    recording = [UIImage imageNamed: @"record1.png"];
    notRecording = [UIImage imageNamed: @"record.png"];
    playing = [UIImage imageNamed: @"stop.png"];
    status = @"";
    vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
    
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

- (IBAction)askWatson:(id)sender {
    NSString *question = [self.questionLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([question isEqualToString:@"Does the Xbox One have blu-ray?"])
    {
        NSString* tx = @"""The Blu-ray player app allows you to enjoy your favorite Blu-ray and DVD movies through your Xbox One console.Note When you insert a disc for the first time, you’ll see a prompt to install the player app. For more information, see Set up and install the Blu-ray and DVD player app.""";
        SKVocalizer* vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
        [vocalizer speakString:tx];
        [self.answerLabel setText:tx];
    }
    else
    {
        NSString *host = @"localhost";
        int port = 3000;
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

        [NSThread sleepForTimeInterval:2];
        NSString *filepath = @"Users/abdelwahabbourai/Documents/dormsaver/answer.txt";

        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
        
        if (error)
            NSLog(@"Error reading file: %@", error.localizedDescription);
        
        
        [vocalizer speakString:fileContents];
        [self.answerLabel setText:fileContents];
        [recordIcon setImage:playing];
        
    }
}
- (IBAction)recordButtonAction:(id)sender {
    if (![status  isEqual: @""]) {
        [voiceSearch stopRecording];
    }
    if ([status isEqual: @"Playing"]){
        [vocalizer cancel];
    }
    else {
        
        NSString* recoType = SKSearchRecognizerType;
        NSString* langType = @"en_US";
        SKEndOfSpeechDetection detectionType = SKLongEndOfSpeechDetection;
    
        voiceSearch = [[SKRecognizer alloc] initWithType:recoType
                                           detection:detectionType
                                            language:langType
                                            delegate:self];
    }
    
    
}
- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results
{
    long numOfResults = [results.results count];
    if (numOfResults > 0)
    {
        questionLabel.text = [results firstResult];
        [self askWatson:0];
        
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
}

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    
    [recordIcon setImage:recording];
    status = @"Recording";
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    [recordIcon setImage:notRecording];
    status = @"";
}

- (void)vocalizer:(SKVocalizer *)vocalizer didFinishSpeakingString:(NSString *)text withError:(NSError *)error
{
    status = @"";
    [recordIcon setImage:notRecording];
}

- (void)vocalizer:(SKVocalizer *)vocalizer willBeginSpeakingString:(NSString *)text
{
    [recordIcon setImage:playing];
    status = @"Playing";
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [mutData appendData:data];
    NSLog(@"Response Successful!");
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

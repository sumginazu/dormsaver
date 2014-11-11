//
//  WatsonViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 10/20/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "WatsonViewController.h"
#import "GCDAsyncSocket.h"
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
NSMutableData *mutData;

- (IBAction)askWatson:(id)sender {
    NSString *question = [self.questionLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([question isEqualToString:@"Does the Xbox One have blu-ray?"])
    {
        [self.answerLabel setText:@"""The Blu-ray player app allows you to enjoy your favorite Blu-ray and DVD movies through your Xbox One console.Note When you insert a disc for the first time, you’ll see a prompt to install the player app. For more information, see Set up and install the Blu-ray and DVD player app."""];
    }
    else
    {
        //[self.answerLabel setText:@"""Answer not available."""];
  /*      NSString *post = question;
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://localhost:8080"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [self.answerLabel setText:@"""Connect!"""];*/
        
        // Create the request.
      /*  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000"]];
        
        // Specify that it will be a POST request
        request.HTTPMethod = @"POST";
        request.timeoutInterval = 20.0;
        // This is how we set header fields
        [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        // Convert your data and set your request's HTTPBody property
        NSString *stringData = question;
        NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = requestBodyData;
        
        // Create url connection and fire request
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if( connection )
        {
            NSLog(@"Connection Successful!");
        }
        else {
            NSLog(@"Connection could not be made");
        }*/
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
        
        NSInputStream *iStream;
        NSURL *url;
        url = [url initWithString:@"http://localhost:3000"];
        
        [iStream initWithURL:url];
        [iStream open];
        
        NSInteger result;
        uint8_t buffer[1024]; // BUFFER_LEN can be any positive integer
        while((result = [iStream read:buffer maxLength:1024]) != 0) {
            if(result > 0) {
                // buffer contains result bytes of data to be handled
            } else {
                // The stream had an error. You can get an NSError object using [iStream streamError]
            }
        }
        /*
        CFReadStreamSetProperty(readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
        if(!CFReadStreamOpen(readStream))
        {
            NSLog(@"Error reading");
        }
        else
        {
         //   [NSThread sleepForTimeInterval: 5];
            UInt8 bufr[1024];
            int bytesRead  = CFReadStreamRead(readStream, bufr,strlen((char*)bufr));
            NSLog(@"Read: %d", bytesRead);
            NSLog(@"buffer: %s", bufr);
        }*/
        
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [mutData appendData:data];
}


/*
 if data is successfully received, this method will be called by connection
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
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
}

@end

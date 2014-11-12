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
        
      /*  NSString *receipt = question;
        
        NSString *post =[NSString stringWithFormat:@"%@",receipt];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://localhost:3001"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        */
       /*NSHTTPURLResponse* urlResponse = nil;
        NSError *error = [[NSError alloc] init];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Response Code: %d", [urlResponse statusCode]);
        if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
        {
            NSLog(@"Response: %@", result);
        }*/
        
      /*  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        NSLog(@"sending!");
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
        {
            
            
            if (error)
            {
                NSLog(@"Error,%@", [error localizedDescription]);
            }
            else
            {
                NSLog(@"a%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
            }
        }];*/
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
      /*  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3001"]];
        
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
        }
        */
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
/*        NSInputStream *iStream;
        NSURL *url;
        url = [url initWithString:@"http://localhost:3001"];
        
//        [iStream initWithURL:url];
 //       [iStream setDelegate:self];
 //       [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
 //       [iStream open];
        NSInteger result;
        NSString *str;
        uint8_t buffer[1024]; // BUFFER_LEN can be any positive integer
        while((result = [iStream read:buffer maxLength:1024]) != 0) {
            if(result > 0) {
                NSLog(@"%d", result);
        //        str = [[NSString alloc] initWithBytes:buffer length:2048 encoding:NSUTF8StringEncoding];
                NSLog(@"buffer: %@", str);
            } else {
                // The stream had an error. You can get an NSError object using [iStream streamError]
            }
        }
        
        str = [[NSString alloc] initWithBytes:buffer length:1024 encoding:NSUTF8StringEncoding];
        NSLog(@"buffer: %@", str);
        CFReadStreamSetProperty(readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
        if(!CFReadStreamOpen(readStream))
        {
            NSLog(@"Error reading");
        }
        else
        {
         //   [NSThread sleepForTimeInterval: 5];
            UInt8 bufr[2048];
            int bytesRead  = CFReadStreamRead(readStream, bufr,strlen((char*)bufr));
            NSString *str1 = [[NSString alloc] initWithBytes:bufr length:bytesRead encoding:NSUTF8StringEncoding];
            NSLog(@"Read: %d", bytesRead);
            NSLog(@"buffer: %s", bufr);
            
            NSLog(str1);
            [self.answerLabel setText: str1];

        }*/
        [NSThread sleepForTimeInterval:1];
        NSString *filepath = @"Users/abdelwahabbourai/Documents/dormsaver/answer.txt";
        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
        
        if (error)
            NSLog(@"Error reading file: %@", error.localizedDescription);
        
        // maybe for debugging...
        NSLog(@"contents: %@", fileContents);
        [self.answerLabel setText: fileContents];
        NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];
        NSLog(@"items = %d", [listArray count]);
    }
}

/*- (void)stream:(NSInputStream *)iStream handleEvent:(NSStreamEvent)event {
    BOOL shouldClose = NO;
    NSLog(@"entered");
    switch(event) {
        case  NSStreamEventEndEncountered:
            shouldClose = YES;
            // If all data hasn't been read, fall through to the "has bytes" event
            if(![iStream hasBytesAvailable]) break;
        case NSStreamEventHasBytesAvailable: ; // We need a semicolon here before we can declare local variables
            uint8_t *buffer;
            NSUInteger length;
            BOOL freeBuffer = NO;
            // The stream has data. Try to get its internal buffer instead of creating one
            if(![iStream getBuffer:&buffer length:&length]) {
                // The stream couldn't provide its internal buffer. We have to make one ourselves
                buffer = malloc(1024 * sizeof(uint8_t));
                freeBuffer = YES;
                NSInteger result = [iStream read:buffer maxLength:1024];
                if(result < 0) {
                    // error copying to buffer
                    break;
                }
                length = result;
            }
            // length bytes of data in buffer
            if(freeBuffer) free(buffer);
            break;
        case NSStreamEventErrorOccurred:
            // some other error
            shouldClose = YES;
            break;
    }
    if(shouldClose) [iStream close];
}*/

/*- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
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
    NSLog(@"Response Successful!");
}
*/

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

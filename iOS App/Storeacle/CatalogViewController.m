//
//  InboxViewController.m
//  Beatlet1
//
//  Created by Sudev Bohra on 8/3/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "CatalogViewController.h"
#import <Parse/Parse.h>


#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
@interface CatalogViewController ()

@end

/*@interface ScrollImageViewController ()

@end*/





@implementation CatalogViewController
{
    NSArray *tableViewValues;
    NSMutableDictionary *dictX;
    NSMutableDictionary *prices;
    NSMutableDictionary *details;

    NSArray *tableViewImages;
    UIScrollView *sView;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadingData];
    [_tableView reloadData] ;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser);
        
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    UIColor * color = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:1.0f];
    UIColor * color1 = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:0.8f];
    [[self view] setBackgroundColor:color];
    _tableView.estimatedRowHeight = 68.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;

  //  NSLog(@"hellolooo");
    self.navigationController.navigationBar.barTintColor = color1;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    [self loadingData];
    
    //tableViewValues = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    // In the method where you will get new values
    //reload table view with new values
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)loadingData{
    
    //code to load the data
    NSArray *lines;
    NSArray *priceArray;
    NSString *filepath = @"Users/abdelwahabbourai/Documents/dormsaver/recommendations.txt";
   // NSMutableCharacterSet *_alnum = [NSMutableCharacterSet characterSetWithCharactersInString:@"_"];
    NSString *pricepath =@"Users/abdelwahabbourai/Documents/dormsaver/prices.txt";
    NSString *s = [NSString stringWithContentsOfFile:filepath encoding: NSASCIIStringEncoding error:NULL];
    NSString *decodedText = [s stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(decodedText);
    NSString *t = [NSString stringWithContentsOfFile:pricepath encoding:NSUTF8StringEncoding error:NULL];
    lines = [decodedText componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    priceArray = [t componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    // NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dictX = [NSMutableDictionary new];
    prices = [NSMutableDictionary new];
    NSMutableArray *final = [[NSMutableArray alloc] init];
    for(NSString *string in priceArray){
        NSArray *p = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@"]];
        // NSLog(urls[0], urls[1]);
        //NSLog(urls);
        //if(sizeof urls == 2){
        NSString *check = [p lastObject];
        if([check isEqualToString:p[0]]){
            
        }
        else{
            //    NSLog(urls[0]);
            //    NSLog(urls[1]);
            //[final addObject:p[0]];
            [prices setValue:p[1] forKey:p[0]];
        }
        
        
        //}
    }
    for(NSString *string in lines){
        NSArray *urls = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"$"]];
       // NSLog(urls[0], urls[1]);
        //NSLog(urls);
        //if(sizeof urls == 2){
                NSString *check = [urls lastObject];
        if([check isEqualToString:urls[0]]){
            
        }
        else{
        //    NSLog(urls[0]);
        //    NSLog(urls[1]);
            [final addObject:urls[0]];
            [dictX setValue:urls[1] forKey:urls[0]];
          //  [details setValue:urls[2] forKey:urls[0]];
        }
        
        
        //}
    }
    NSArray *array = [final copy];
   // NSLog(dictX);
    
    
    
    // NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
   // NSLog(@"%@",array);
    tableViewValues = array;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewValues count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this method is called for each cell and returns height
    NSString * text = @"Your very long text";
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize: 14.0] forWidth:[tableView frame].size.width - 40.0 lineBreakMode:UILineBreakModeWordWrap];
    // return either default height or height to fit the text
    return textSize.height < 44.0 ? 44.0 : textSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    UIColor * aColor = [UIColor colorWithRed:67/255.0f green:66/255.0f blue:85/255.0f alpha:1.0f];
    cell.backgroundColor =  aColor;
    UIColor * whiteColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    UIColor * grayColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f];
    cell.textColor= whiteColor;
    //cell.textLabel.numberOfLines = 0;
   // cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    //NSString *url = [dictX objectForKey:[tableViewValues objectAtIndex:indexPath.row]];
    //NSString *urlpath = [url stringByAppendingString:@".jpg"];
    //NSString* theFileName = [[url lastPathComponent] stringByDeletingPathExtension];
    //NSString *myExtension = [url pathExtension];
    //NSString *imagepath = [theFileName stringByAppendingString:@"."];
    
    //imagepath = [imagepath stringByAppendingString:myExtension];
    //NSLog(imagepath);
    //cell.imageView.image = [UIImage imageNamed: imagepath];
    cell.textLabel.text = [tableViewValues objectAtIndex:indexPath.row];
    //NSLog(cell.textLabel.text);
    NSLog([prices objectForKey:[tableViewValues objectAtIndex:indexPath.row]]);
    cell.detailTextLabel.text = [prices objectForKey:[tableViewValues objectAtIndex:indexPath.row]];
    cell.detailTextLabel.textColor = grayColor;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;

    //cell.imageView.image = [UIImage imageNamed:@"creme_brulee.jpg" ];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [dictX objectForKey:[tableViewValues objectAtIndex:indexPath.row]];
    NSLog(url);
    NSString *fixedURL = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *encodedText = [fixedURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    
    NSURL* nUrl = [NSURL URLWithString:encodedText];
    
    NSLog(@"%@", [nUrl absoluteURL]);
    //NSLog(encodedText);
    //NSURL *u = [ [ NSURL alloc ] initWithString: url ];

    //NSURL * urlu = [[NSURL alloc] initWithString:encodedString];
   // NSLog(urlu);
    //NSString *urlpath = [url stringByAppendingString:url];
    //NSLog(urlpath);
    // [[UIApplication sharedApplication] openURL:url];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:encodedText]];

}

- (IBAction)signout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}


@end
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
    NSString *filepath = @"Users/abdelwahabbourai/Documents/dormsaver/recommendations.txt";
   // NSMutableCharacterSet *_alnum = [NSMutableCharacterSet characterSetWithCharactersInString:@"_"];

    NSString *s = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:NULL];
    lines = [s componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    // NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dictX = [NSMutableDictionary new];
    NSMutableArray *final = [[NSMutableArray alloc] init];
    for(NSString *string in lines){
        NSArray *urls = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"$"]];
        NSLog(urls[0]);
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
    NSString *url = [NSURL URLWithString: [dictX objectForKey:[tableViewImages objectAtIndex:indexPath.row]]];
    NSLog(url);
    //cell.imageView.image = [UIImage imageNamed: imageData];
    cell.textLabel.text = [tableViewValues objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"$5";
    cell.detailTextLabel.textColor = grayColor;
   // cell.imageView.image = [UIImage imageNamed: imageData];
    
    return cell;
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
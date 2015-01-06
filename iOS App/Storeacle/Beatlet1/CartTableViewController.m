//
//  CartTableViewController.m
//  Beatlet12
//
//  Created by Sudev Bohra on 11/25/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import "CartTableViewController.h"
#import <Parse/Parse.h>
@interface CartTableViewController ()

@end

@implementation CartTableViewController
{
    NSArray *tableViewValues;
    NSArray *prices;
    NSArray *images;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser);
        
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

    UIColor * color = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0f];
    UIColor * color1 = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0f];
    [[self view] setBackgroundColor:color];
    self.navigationController.navigationBar.barTintColor = color;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor]];
    tableViewValues = [NSArray arrayWithObjects:@"iPhone 6, White 16GB", @"Samsung Galaxy S5, Black 16GB", nil];
    prices = [NSArray arrayWithObjects:@"$649.99", @"$524.99", nil];
    images = [NSArray arrayWithObjects:@"iPhone6White.jpg",@"SamsungGalaxyS5.jpg", nil];
    NSLog(@"%@",tableViewValues);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [tableViewValues count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    UIColor * aColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0f];;
    cell.backgroundColor =  aColor;
    UIColor * whiteColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    UIColor * grayColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:150/255.0f alpha:1.0f];
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
    
    cell.imageView.image = [UIImage imageNamed: [images objectAtIndex:indexPath.row]];
    cell.textLabel.text = [tableViewValues objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [prices objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = grayColor;
    NSLog(cell.textLabel.text);
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

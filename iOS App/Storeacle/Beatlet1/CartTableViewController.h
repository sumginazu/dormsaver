//
//  CartTableViewController.h
//  Beatlet12
//
//  Created by Sudev Bohra on 11/25/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CartTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    IBOutlet UITableView *tableView;
}
- (IBAction)signout:(id)sender;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIWebView *myWebView;

@end
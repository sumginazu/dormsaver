//
//  InboxViewController.h
//  Beatlet1
//
//  Created by Sudev Bohra on 8/3/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import <UIKit/UIKit.h>
/*@interface ScrollImageViewController : UIViewController {
    UIScrollView *scrollView;
}
@property(nonatomic,retain)UIScrollView *scrollView;
@end*/

@interface CatalogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    IBOutlet UITableView *tableView;
}
- (IBAction)signout:(id)sender;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end



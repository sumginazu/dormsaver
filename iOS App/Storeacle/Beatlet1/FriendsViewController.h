//
//  FriendsViewController.h
//  Beatlet1
//
//  Created by Sudev Bohra on 8/6/14.
//  Copyright (c) 2014 Sudev Bohra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsViewController : UITableViewController
@property (nonatomic, strong) PFRelation* friendsRelation;
@property (nonatomic, strong) NSArray* friends;
@end

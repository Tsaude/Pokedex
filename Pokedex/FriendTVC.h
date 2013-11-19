//
//  FriendTVC.h
//  Pokedex
//
//  Created by Tucker Saude on 5/22/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PokedexLoginViewController.h"

@interface FriendTVC : UITableViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray* pokedexObjects;

-(void)reloadTable;
- (IBAction)addPokedex:(id)sender;

@end

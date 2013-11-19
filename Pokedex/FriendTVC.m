//
//  FriendTVC.m
//  Pokedex
//
//  Created by Tucker Saude on 5/22/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import "FriendTVC.h"

@interface FriendTVC ()

@end

@implementation FriendTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //PFQuery* query = [PFQuery queryWithClassName:@"PartnerPokedex"];
        //[PFUser query]where
    }
    return self;
}

-(void)reloadTable{
    
}

- (IBAction)addPokedex:(id)sender {
    PFObject* newPokedex = [PFObject objectWithClassName:@"PartnerPokedex"];
    [newPokedex setObject:[PFUser currentUser] forKey:@"createdBy"];
    [newPokedex setObject:@"Tucker's Awesome Pokedex" forKey:@"name"];
    [self.pokedexObjects addObject:[newPokedex objectForKey:@"objectId"]];
    [[PFUser currentUser] setObject:self.pokedexObjects forKey:@"PartnerPokedexs"];
    [self reloadTable];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    if(![PFUser currentUser]){
        PokedexLoginViewController* login = [[PokedexLoginViewController alloc]init];
        [login setDelegate:self];
        [self presentViewController:login animated:YES completion:NULL];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([PFUser currentUser]){
        NSMutableArray* partnerArray = [[PFUser currentUser] objectForKey:@"PartnerPokedexs"];
        self.pokedexObjects = partnerArray;
        NSInteger count = [partnerArray count];
        return count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString* name = [[self.pokedexObjects objectAtIndex:indexPath.row] name];
    return cell;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end

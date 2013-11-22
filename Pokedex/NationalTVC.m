//
//  PokedexTVC.m
//  Pokedex
//
//  Created by Tucker Saude on 3/6/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import "NationalTVC.h"
#import <Parse/Parse.h>
@interface NationalTVC ()

@end

@implementation NationalTVC


-(id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self){
        
    }
    return self;
}

-(id)initWithStyle:(UITableViewStyle)style{
    return [self init];
}

-(NSString*)docsDir{
    //helper method
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    // Return the number of sections.
    return 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //configure pokedex from plist
    listPath = [[self docsDir] stringByAppendingPathComponent:@"nat.plist"];
    myListPath = listPath;
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]){
        //create new plist in device, using contents of the plist.
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"nat" ofType:@"plist"] toPath:listPath error:nil];
    }
    self.pokedex = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];//create your pokedex
    self.filteredPokedex = [[NSMutableArray alloc]init]; //create array for filtered pokedex
    self.natPokedex = self.pokedex; //national dex specific
    self.filteredPokedexChecker = [NSMutableArray arrayWithCapacity:self.pokedex.count]; //create array to store the search items
    
    NSLog(@"starting filter pokedex checker loop"); //add pokemon to said array
    for(int x = 1; x<=self.pokedex.count; x++){
        NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", x]];
        NSString* picString = [[pokeDict objectForKey:@"pic"] substringToIndex:3];
        Pokemon* pkm = [[Pokedex sharedPokedex].pokeList objectAtIndex:picString.intValue -1];
        [self.filteredPokedexChecker addObject:pkm];
    }
    NSLog(@"I be hurr");
    self.refreshControl = [[UIRefreshControl alloc] init]; //create our refresh control
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView reloadData];

    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

}

-(int)countThePokemon{
    int numberOfCaughtPokemon = 0;
    for(id key in self.pokedex){
        NSDictionary* pkm  =[self.pokedex objectForKey:key];
        int pokemonNumber = [[pkm objectForKey:@"pic"] substringToIndex:3].intValue;
        
        Pokemon* pokemon = [[[Pokedex sharedPokedex] pokeList]objectAtIndex:pokemonNumber-1];
        if (pokemon.isCaught) {
            numberOfCaughtPokemon++;
        }
        
    }
    return numberOfCaughtPokemon;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"count of filtered pokedex: %d", self.filteredPokedex.count);
        return [self.filteredPokedex count];
    } else {
        return [self.pokedex count]+1;// Change
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
   
    if (indexPath.row == 0 && tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TallyCell"];
        int numberCaughtPokemon = [self countThePokemon];
        cell.textLabel.text = [NSString stringWithFormat:@"%d/%d", numberCaughtPokemon, self.pokedex.count];
        [cell setUserInteractionEnabled:NO];
    }else{
    
        //setup to get the right pokemon
        NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
        NSArray* objects = [[pokeDict objectForKey:@"pic"] componentsSeparatedByString:@"."];
        int pokenumber = [[objects objectAtIndex:0] intValue];
        Pokemon*pkm;
        
        
        //checks if search is open and grabs the right pkm object
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            pkm = [self.filteredPokedex objectAtIndex:indexPath.row];  
        }else {
            pkm = [[[Pokedex sharedPokedex] pokeList]objectAtIndex:pokenumber-1]; //change
        }
        
        //configure cell names
        [[cell textLabel] setText:pkm.name]; //cell Name
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d", indexPath.row]]; //Cell detail
        UIImage* img = [UIImage imageNamed:pkm.image]; //get image
        [cell.imageView setImage:img];// set cell Image
        
        if ([pkm isCaught]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }

    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]]; //grabbing pokemon from plist, so we know what order they go in, in the pokedex
    NSArray* objects = [[pokeDict objectForKey:@"pic"] componentsSeparatedByString:@"."]; //splits the pic number to get national dex number
    int pokenumber = 0;
    if (tableView == self.searchDisplayController.searchResultsTableView){
        Pokemon* searchPkm= [self.filteredPokedex objectAtIndex:indexPath.row];
        pokenumber = [searchPkm.image substringToIndex:3].intValue;
    }else{
         pokenumber = [[objects objectAtIndex:0] intValue];
        NSLog(@"pokenumber = %d", pokenumber);
    }
    
    //NSMutableDictionary* natPokeDict = [self.natPokedex objectForKey:[NSString stringWithFormat:@"%d",pokenumber]];
    Pokemon* pkm;
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        pkm = [self.filteredPokedex objectAtIndex:indexPath.row];
    } else {
        pkm = [[[Pokedex sharedPokedex] pokeList]objectAtIndex:pokenumber-1];
    }
    NSLog(@"pokemon after selecting:%@", pkm);
    pkm.caught = !pkm.caught;
    [[[Pokedex sharedPokedex]isCaughtArray] replaceObjectAtIndex:pkm.dexNumber.intValue-1  withObject:[NSNumber numberWithBool:pkm.caught]];
    NSLog(@"dexnumber = %d", pkm.dexNumber.intValue);
   // NSLog(@"Array is %d", newIsCaughtArray.count);
   // [newIsCaughtArray replaceObjectAtIndex:(pkm.dexNumber.intValue)-1 withObject:[NSNumber numberWithBool:pkm.caught]];
     //insertObject:[NSNumber numberWithBool:pkm.caught] atIndex:(pkm.dexNumber.intValue)-1];
    
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
    
    NSLog(@"here");
   // dispatch_queue_t q = dispatch_queue_create("table view loading queue", NULL); dispatch_async(q, ^{
    NSLog(@"setting object");
    [[[Pokedex sharedPokedex] isCaughtObject] setObject:[Pokedex sharedPokedex].isCaughtArray forKey:@"isCaughtArray"];
        
        NSLog(@"starting save in background");
    [[[Pokedex sharedPokedex]isCaughtObject]saveInBackground];
    
   //});
    
    
   /*
    NSLog(@"natDict = the pokemon: %@", natPokeDict);
    if ([pkm isCaught]) {
        [natPokeDict setObject:@1 forKey:@"isCaught"];
        [self.natPokedex writeToFile:listPath atomically:YES];
    }else{
        [natPokeDict setObject:@0 forKey:@"isCaught"];
        [self.natPokedex writeToFile:listPath atomically:YES];
    }
    */
    
    
}


#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredPokedex removeAllObjects];
    
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@",searchText];
    self.filteredPokedex = [NSMutableArray arrayWithArray:[self.filteredPokedexChecker filteredArrayUsingPredicate:predicate]];
    
    
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    

    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(IBAction)refresh
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing Data..."];
    //refresh logic
    // show the spinner if it's not already showing
    [self.refreshControl beginRefreshing];
    dispatch_queue_t q = dispatch_queue_create("table view loading queue", NULL);
    dispatch_async(q, ^{
        [[Pokedex sharedPokedex] RefreshPokedex];
        
       dispatch_async(dispatch_get_main_queue(), ^{
            [[Pokedex sharedPokedex] UpdatePokedex];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            NSString* lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastUpdated];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
            
        });
    });

    
    }

@end

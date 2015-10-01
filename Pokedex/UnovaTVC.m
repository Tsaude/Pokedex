//
//  UnovaTVC.m
//  Pokedex
//
//  Created by Tucker Saude on 3/18/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import "UnovaTVC.h"

@interface UnovaTVC ()

@end

@implementation UnovaTVC

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
    
    
    listPath = [[self docsDir] stringByAppendingPathComponent:@"nat.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]){
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"nat" ofType:@"plist"] toPath:listPath error:nil];
    }
    self.natPokedex = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
    self.filteredPokedex = [NSMutableArray arrayWithCapacity:self.pokedex.count];
    self.filteredPokedexChecker = [NSMutableArray arrayWithCapacity:self.pokedex.count];
    
    NSLog(@"starting filter pokedex checker loop");
    for(int x = 0; x<self.pokedex.count; x++){
        NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", x]];
        NSString* picString = [[pokeDict objectForKey:@"pic"] substringToIndex:3];
        NSLog(@"%@", picString);
        Pokemon* pkm = [[Pokedex sharedPokedex].pokeList objectAtIndex:picString.intValue -1];
        [self.filteredPokedexChecker addObject:pkm];
    }
    self.numberCaughtPokemon = 0;//add
    self.numberAvailablePokemon = self.pokedex.count;//add
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    
    //setup to get the right pokemon
    NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%@", @(indexPath.row)]];
    NSArray* objects = [[pokeDict objectForKey:@"pic"] componentsSeparatedByString:@"."];
    int pokenumber = [[objects objectAtIndex:0] intValue];
    Pokemon*pkm;
    
    
    //checks if search is open and grabs the right pkm object
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        pkm = [self.filteredPokedex objectAtIndex:indexPath.row];
    }else {
        pkm = [[[Pokedex sharedPokedex] pokeList]objectAtIndex:pokenumber-1];
    }
    
    //configure cell names
    [[cell textLabel] setText:pkm.name]; //cell Name
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", @(indexPath.row)]]; //Cell detail
    UIImage* img = [UIImage imageNamed:pkm.image]; //get image
    [cell.imageView setImage:img];// set cell Image
    
    if ([pkm isCaught]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    myListPath = [[self docsDir]stringByAppendingPathComponent:@"uBW.plist"];
    
    	
    if(![[NSFileManager defaultManager]fileExistsAtPath:myListPath]){
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"uBW" ofType:@"plist"] toPath:myListPath error:nil];
    }
    
    self.pokedex = [NSMutableDictionary dictionaryWithContentsOfFile:myListPath];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"count of filtered pokedex: %lu", (unsigned long)self.filteredPokedex.count);
        return [self.filteredPokedex count];
    }else{
        return [self.pokedex count];
    }
}


@end

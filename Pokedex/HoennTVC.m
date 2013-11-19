//
//  HoennTVC.m
//  Pokedex
//
//  Created by Tucker Saude on 3/15/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import "HoennTVC.h"

@interface HoennTVC ()

@end

@implementation HoennTVC

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
    for(int x = 1; x<=self.pokedex.count; x++){
        NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", x]];
        NSString* picString = [[pokeDict objectForKey:@"pic"] substringToIndex:3];
        Pokemon* pkm = [[Pokedex sharedPokedex].pokeList objectAtIndex:picString.intValue -1];
        [self.filteredPokedexChecker addObject:pkm];
    }

    self.numberCaughtPokemon = 0;//add
    self.numberAvailablePokemon = self.pokedex.count;//add
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    myListPath = [[self docsDir]stringByAppendingPathComponent:@"h.plist"];
    
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:myListPath]){
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"hRSE" ofType:@"plist"] toPath:myListPath error:nil];
    }
    
    self.pokedex = [NSMutableDictionary dictionaryWithContentsOfFile:myListPath];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"count of filtered pokedex: %d", self.filteredPokedex.count);
        return [self.filteredPokedex count];
    }else{
        return [self.pokedex count]+1;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

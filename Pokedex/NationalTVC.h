//
//  PokedexTVC.h
//  Pokedex
//
//  Created by Tucker Saude on 3/6/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//


#import "Pokedex.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NationalTVC : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSString* myListPath;
    NSString *listPath;

}
@property (nonatomic, strong) NSMutableDictionary* pokedex;
@property (nonatomic, strong) NSMutableArray *filteredPokedex;
@property (nonatomic, weak)   IBOutlet UISearchBar* pokemonSearchBar;
@property (nonatomic, strong) NSMutableDictionary* natPokedex;
@property (nonatomic, strong) NSMutableArray* filteredPokedexChecker;
@property (nonatomic) NSInteger numberCaughtPokemon;
@property (nonatomic) NSInteger numberAvailablePokemon;


-(NSString*)docsDir;
-(int)countThePokemon;
@end

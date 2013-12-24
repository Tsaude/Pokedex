//
//  NationalCVC.h
//  Pokedex
//
//  Created by Tucker Saude on 12/23/13.
//  Copyright (c) 2013 Tucker Saude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PokemonCVCell.h"
#import "Pokemon.h"
#import "Pokedex.h"

@interface NationalCVC : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSString* myListPath;
    NSString *listPath;
}

@property (nonatomic, strong) UIRefreshControl * refreshControl;
@property (nonatomic, strong) NSMutableDictionary* natPokedex;
@property (nonatomic, strong) NSMutableArray* filteredPokedexChecker;
@property (nonatomic) NSInteger numberCaughtPokemon;
@property (nonatomic) NSInteger numberAvailablePokemon;
@property (nonatomic, strong) NSMutableDictionary* pokedex;
@property (nonatomic, strong) NSMutableArray *filteredPokedex;

@end

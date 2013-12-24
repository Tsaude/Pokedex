//
//  PokemonCVCell.h
//  Pokedex
//
//  Created by Tucker Saude on 12/23/13.
//  Copyright (c) 2013 Tucker Saude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface PokemonCVCell : UICollectionViewCell

@property (strong, nonatomic) Pokemon * pokemon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sprite;
@property (weak, nonatomic) IBOutlet UIImageView *background;



-(id)initWithFrame:(CGRect)frame andPokemon:(Pokemon *)pokemon;
@end

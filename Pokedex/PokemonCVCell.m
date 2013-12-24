//
//  PokemonCVCell.m
//  Pokedex
//
//  Created by Tucker Saude on 12/23/13.
//  Copyright (c) 2013 Tucker Saude. All rights reserved.
//

#import "PokemonCVCell.h"

@implementation PokemonCVCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andPokemon:(Pokemon *)pokemon{
    
    self = [self initWithFrame:frame];

    return self;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end

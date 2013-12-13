//
//  Pokedex.h
//  Pokedex
//
//  Created by Tucker Saude on 3/8/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#import <Parse/Parse.h>

@interface Pokedex : NSObject
{
    NSString *listPath;
}

@property (strong, nonatomic) NSMutableArray* pokeList; //of Pokemon
@property (strong, nonatomic) NSMutableDictionary* pokeDictionary;
@property (strong, nonatomic) NSMutableArray* isCaughtArray;
@property (strong, nonatomic) PFObject* isCaughtObject;

+(Pokedex *) sharedPokedex;
-(NSString*) docsDir;
-(void)RefreshPokedex;
-(void)UpdatePokedex;

@end

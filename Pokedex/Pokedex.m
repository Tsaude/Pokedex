//
//  Pokedex.m
//  Pokedex
//
//  Created by Tucker Saude on 3/8/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import <Parse/Parse.h>
#import "Pokemon.h"
#import "Pokedex.h"

@interface Pokedex()
@property (strong, nonatomic) NSMutableArray* pokemon; //of Pokemon
@end

@implementation Pokedex

+(Pokedex*) sharedPokedex{
    static Pokedex *sharedPokedex= nil;
    if (!sharedPokedex) {
        sharedPokedex = [[super allocWithZone:nil]init];
    }
    return sharedPokedex;
}

+(id)allocWithZone:(NSZone *)zone{
    return [self sharedPokedex];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self RefreshPokedex];
        [self UpdatePokedex];
           }

    return self;
}
-(NSString*)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

-(void)RefreshPokedex{
    
    if (!self.isCaughtArray){
        
        PFQuery *query = [PFQuery queryWithClassName:@"temporary"];
        //PFObject *isCaughtArrayObject = [query getObjectWithId:@"BRWtAyb26Q"];
        
        [query getObjectInBackgroundWithId:@"BRWtAyb26Q" block:^(PFObject* object, NSError * error){
            self.isCaughtObject = object;
            self.isCaughtArray = (NSMutableArray *)[self.isCaughtObject objectForKey:@"isCaughtArray"];
        }];
        

       // NSLog(@"getting is caught array");
               
    }else{
        [self.isCaughtObject refresh];
        self.isCaughtArray = [self.isCaughtObject objectForKey:@"isCaughtArray"];
        //NSLog(@"%@",[[self.isCaughtArray objectAtIndex:0] stringValue]);
    }
}

-(NSMutableArray*)notCaughtPokemon{
    NSMutableArray* notCaughtPokeArray = [[NSMutableArray alloc]initWithCapacity:self.pokeList.count];
    for( Pokemon* pkm in self.pokeList){
        if(!pkm.isCaught){
            [notCaughtPokeArray addObject:pkm];
        }
    }
    return notCaughtPokeArray;
}


-(void)UpdatePokedex{
    if(!self.pokeList){
        self.pokeList = [[NSMutableArray alloc]init];
    }
    listPath = [[self docsDir]stringByAppendingPathComponent:@"nat.plist"];
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]){
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"nat" ofType:@"plist"] toPath:listPath error:nil];
    }
    
    self.pokeDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
    
    for (int i = 1; i<650; i++) {
        BOOL caught;
        
        NSDictionary* dict = [self.pokeDictionary objectForKey:[NSString stringWithFormat:@"%i", i]];
        caught = [[self.isCaughtArray objectAtIndex:i-1] boolValue];
        //caught = [[dict objectForKey:@"isCaught"] boolValue];
        Pokemon* pkm = [[Pokemon alloc]initWithName:[dict objectForKey:@"name"] number:[dict objectForKey:@"num"] image:[dict objectForKey:@"pic"]];
        pkm.caught = caught;
        //if (i == 1) {
         //   NSLog(@"initialized: %s", pkm.caught ? "true" : "false");
        //}
       // NSLog(@"%d", i);
        [self.pokeList insertObject:pkm atIndex:i-1];
        
        
        
    }
}

@end

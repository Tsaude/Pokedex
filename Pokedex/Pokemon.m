//
//  Pokemon.m
//  Pokedex
//
//  Created by Tucker Saude on 3/8/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import "Pokemon.h"

@interface Pokemon()

@end


@implementation Pokemon

- (id)initWithName:(NSString*)name number:(NSString*)number image:(NSString*)image
{
    self = [super init];
    if (self) {
        self.name = name;
        self.dexNumber = number;
        self.image = image;
        self.caught = NO;
    }
    return self;
}

-(NSString*)description{
    return self.name;
}

@end

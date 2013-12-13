//
//  Pokemon.h
//  Pokedex
//
//  Created by Tucker Saude on 3/8/13.
//  Copyright (c) 2013 Saude Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pokemon : NSObject
@property (strong, nonatomic) NSString * dexNumber;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * image;
@property (nonatomic, getter = isCaught) BOOL caught;


- (id)initWithName:(NSString*)name number:(NSString*)number image:(NSString*)image;





@end

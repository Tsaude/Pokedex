//
//  NationalCVC.m
//  Pokedex
//
//  Created by Tucker Saude on 12/23/13.
//  Copyright (c) 2013 Tucker Saude. All rights reserved.
//

#import "NationalCVC.h"



@interface NationalCVC ()

@end

@implementation NationalCVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)docsDir{
    //helper method
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    //configure pokedex from plist
    listPath = [[self docsDir] stringByAppendingPathComponent:@"nat.plist"];
    myListPath = listPath;
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]){
        //create new plist in device, using contents of the plist.
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"nat" ofType:@"plist"] toPath:listPath error:nil];
    }
    self.pokedex = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];//create your pokedex
    self.filteredPokedex = [[NSMutableArray alloc]init]; //create array for filtered pokedex
    self.natPokedex = self.pokedex; //national dex specific
    self.filteredPokedexChecker = [NSMutableArray arrayWithCapacity:self.pokedex.count]; //create array to store the search items
    
    NSLog(@"starting filter pokedex checker loop"); //add pokemon to said array
    for(int x = 1; x<=self.pokedex.count; x++){
        NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", x]];
        NSString* picString = [[pokeDict objectForKey:@"pic"] substringToIndex:3];
        Pokemon* pkm = [[Pokedex sharedPokedex].pokeList objectAtIndex:picString.intValue -1];
        [self.filteredPokedexChecker addObject:pkm];
    }
    
        [self.collectionView reloadData];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    

    

    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pokedex.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    PokemonCVCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PokemonCell" forIndexPath:indexPath];
    

    
    /*if (indexPath.row == 0 && tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TallyCell"];
        int numberCaughtPokemon = [self countThePokemon];
        cell.textLabel.text = [NSString stringWithFormat:@"%d/%d", numberCaughtPokemon, self.pokedex.count];
        [cell setUserInteractionEnabled:NO];
    }else{*/
        
        //setup to get the right pokemon
    
    NSDictionary* pokeDict = [self.pokedex objectForKey:[NSString stringWithFormat:@"%d", indexPath.item]];
    NSLog(@"%d", indexPath.item);
    NSArray* objects = [[pokeDict objectForKey:@"pic"] componentsSeparatedByString:@"."];
    int pokenumber = [[objects objectAtIndex:0] intValue];
    Pokemon*pkm;
    
    
    //checks if search is open and grabs the right pkm object
    //if (collectionView == self.searchDisplayController.searchResultsTableView) {
      //  pkm = [self.filteredPokedex objectAtIndex:indexPath.row];
    //}else {
        pkm = [[[Pokedex sharedPokedex] pokeList]objectAtIndex:pokenumber]; //change
    //}
    
    //configure cell names
    cell.pokemon = pkm;
    
    //cell Name should be taken care of inside the cell
    
    //[cell.detailTextLabel setText:[NSString stringWithFormat:@"%d", indexPath.row]]; //Cell detail
    UIImage* img = [UIImage imageNamed:pkm.image]; //get image
    [cell.sprite setImage:img];// set cell Image
    
    if ([pkm isCaught]) {
        [cell.background setImage:[UIImage imageNamed:@"pokeball.png"]];
    }else{
        [cell.background setImage:[UIImage imageNamed:@"pokeballDim.png"]];
    }
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:26], NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,[UIColor whiteColor], NSStrokeColorAttributeName,nil];

    [pkm.name drawInRect:cell.name.frame withAttributes:dictionary];

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(IBAction)refresh
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing Data..."];
    //refresh logic
    // show the spinner if it's not already showing
    [self.refreshControl beginRefreshing];
    dispatch_queue_t q = dispatch_queue_create("table view loading queue", NULL);
    dispatch_async(q, ^{
        [[Pokedex sharedPokedex] RefreshPokedex];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[Pokedex sharedPokedex] UpdatePokedex];
           // NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            //[formatter setDateFormat:@"MMM d, h:mm a"];
            //NSString* lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
            //self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastUpdated];
            [self.refreshControl endRefreshing];
            [self.collectionView reloadData];
            
        });
    });
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

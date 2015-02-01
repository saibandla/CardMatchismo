//
//  PlayingCard.h
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property(nonatomic,strong)NSString *suit;
@property(nonatomic)NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger )maxRank;
@end

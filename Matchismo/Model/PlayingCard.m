//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit=_suit;
-(NSString *)contents
{
    NSArray *rankStrings=[PlayingCard rankStrings];
    return [rankStrings[(int)self.rank] stringByAppendingString: self.suit];
}
-(int)match:(NSArray *)othercards
{
    int score=0;
    if(othercards.count==1)
    {
        PlayingCard *otherCard=[othercards firstObject];
        if(self.rank==otherCard.rank)
        {
            score=4;
        }
        else if ([self.suit isEqualToString:otherCard.suit])
        {
            score=1;
        }
    }
    return score;
}

+(NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit=suit;
    }
}
-(NSString *)suit
{
    return _suit?_suit:@"?";
}
+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSUInteger )maxRank
{
    return [self rankStrings].count-1;
}
-(void)setRank:(NSUInteger )rank
{
    if(rank<=[PlayingCard maxRank])
    {
        _rank=rank;
    }
}
@end



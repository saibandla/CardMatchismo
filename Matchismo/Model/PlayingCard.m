//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "PlayingCard.h"
@interface PlayingCard()
@property(nonatomic,strong)NSMutableString *matchResult;

@end
@implementation PlayingCard
@synthesize suit=_suit;
-(NSMutableString *)matchResult
{
    if (!_matchResult) {
        _matchResult=[[NSMutableString alloc]initWithString:@"Matched"];
    }
    return _matchResult;
}
-(NSString *)contents
{
    NSArray *rankStrings=[PlayingCard rankStrings];
    return [rankStrings[(int)self.rank] stringByAppendingString: self.suit];
}
-(NSArray *)match:(NSArray *)othercards gamePlayMode:(int)mode
{
    _matchResult=nil;
    int score=0;
    if(othercards.count==1&&mode==2)
    {
        PlayingCard *otherCard=[othercards firstObject];
        if((self.rank==otherCard.rank)||([self.suit isEqualToString:otherCard.suit]))
        {
            [self.matchResult appendString:[NSString stringWithFormat:@" %@ %@ ",self.contents,otherCard.contents]];
            [self setMatched:YES];
            [otherCard setMatched:YES];
        }
        else
        {
            [self.matchResult setString:[NSString stringWithFormat:@" %@ %@ don't match! 2 points penalty!",self.contents,otherCard.contents]];
        }
        if(self.rank==otherCard.rank)
        {
            score=4;
        }
        else if ([self.suit isEqualToString:otherCard.suit])
        {
            score=1;
        }
    }
    else if(othercards.count==2&&mode==3)
    {
        PlayingCard *firstOtherCard=[othercards firstObject];
        PlayingCard *lastOtherCard=[othercards lastObject];
        if((self.rank==firstOtherCard.rank)||([self.suit isEqualToString:firstOtherCard.suit]))
        {
            [self.matchResult appendString:[NSString stringWithFormat:@" %@ %@ ",self.contents,firstOtherCard.contents]];
            self.matched=YES;
            firstOtherCard.matched=YES;
            
        }
        else if((self.rank==lastOtherCard.rank)||([self.suit isEqualToString:lastOtherCard.suit]))
        {
            [self.matchResult appendString:[NSString stringWithFormat:@" %@ %@ ",self.contents,lastOtherCard.contents]];
            self.matched=YES;
            lastOtherCard.matched=YES;
        }
        else if((firstOtherCard.rank==lastOtherCard.rank)||([firstOtherCard.suit isEqualToString:lastOtherCard.suit]))
        {
            [self.matchResult appendString:[NSString stringWithFormat:@" %@ %@ ",firstOtherCard.contents,lastOtherCard.contents]];
            firstOtherCard.matched=YES;
            lastOtherCard.matched=YES;
        }
        else
        {
            [self.matchResult setString:[NSString stringWithFormat:@" %@ %@ %@ don't match! 2 points penalty!",self.contents,firstOtherCard.contents,lastOtherCard.contents]];
        }
        if(self.rank==firstOtherCard.rank)
        {
            score+=4;
        }
        else if([self.suit isEqualToString:firstOtherCard.suit])
        {
            score+=1;
        }
        if(self.rank==lastOtherCard.rank)
        {
            score+=4;
        }
        else if([self.suit isEqualToString:lastOtherCard.suit])
        {
            score+=1;
        }
        if(firstOtherCard.rank==lastOtherCard.rank)
        {
            score+=4;
        }
        else if([firstOtherCard.suit isEqualToString:lastOtherCard.suit])
        {
            score+=1;
        }
        
    }
    return @[[NSNumber numberWithInt:score],score?[self.matchResult stringByAppendingString:[NSString stringWithFormat:@"for %d points",score]]:self.matchResult  ];
}
-(NSString *)getMatchResult
{
    return self.matchResult;
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



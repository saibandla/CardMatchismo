//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property(nonatomic,readwrite)NSInteger score;
@property(nonatomic,strong)NSMutableArray *cards;// of Card
@end
@implementation CardMatchingGame
-(NSMutableArray *)cards
{
    if(!_cards)
    {
        _cards=[[NSMutableArray alloc]init];
    }
    
    return _cards;
}
-(instancetype)init
{
    return nil;
}
static const int MISMATCH_PENALITY=2;
static const int MATCH_BONUS=4;
static const int COST_TO_CHOOSE=1;
-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card=[self cardAtIndex:index];
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen=NO;
        }
        else
        {
            for(Card *othercard in self.cards)
            {
                if(othercard.isChosen&&!othercard.isMatched)
                {
                    int matchScore=[card match:@[othercard]];
                    if(matchScore)
                    {
                        self.score+=matchScore*MATCH_BONUS;
                        othercard.matched=YES;
                        card.matched=YES;
                    }
                    else
                    {
                        self.score-=MISMATCH_PENALITY;
                        othercard.chosen=NO;
                    }
                    break;
                }
                
            }
            
            
            
            self.score-=COST_TO_CHOOSE;
            
            
            card.chosen=YES;
        }
    }
}
-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<self.cards.count)?self.cards[index]:nil;
}
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self=[super init];
    if(self)
    {
        for(int i=0;i<count;i++)
        {
            Card *card=[deck drawRandomCard];
            if(card)
            {
            [self.cards addObject:card];
            }
            else
            {
                self=nil;
                break;
            }
        }
    }
    return self;
}
@end

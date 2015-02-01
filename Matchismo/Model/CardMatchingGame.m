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
    self.resultString=card.contents;
    
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen=NO;
        }
        else
        {
            NSMutableArray *othercardsArray=[[NSMutableArray alloc]init];
            for(Card *othercard in self.cards)
            {
                if(othercard.isChosen&&!othercard.isMatched)
                {
                    [othercardsArray addObject:othercard];
                    NSArray *matchResultInfo=[card match:othercardsArray  gamePlayMode:self.gameplaymode];
                    int matchScore=[[matchResultInfo objectAtIndex:0] integerValue];
                    if(matchScore)
                    {
                        self.score+=matchScore*MATCH_BONUS;
                        if(self.gameplaymode==2)
                        {
                            self.resultString=[matchResultInfo objectAtIndex:1];
                        }
                        else if(othercardsArray.count==2&&self.gameplaymode==3)
                        {
                            self.resultString=[matchResultInfo objectAtIndex:1];
                        }
                        else
                        {
                            self.resultString=card.contents;
                        }
                        //                        othercard.matched=YES;
                        //                        card.matched=YES;
                    }
                    else
                    {
                        if(self.gameplaymode==2)
                        {
                            self.score-=MISMATCH_PENALITY;
                            othercard.chosen=NO;
                            self.resultString=[matchResultInfo objectAtIndex:1];
                        }
                        else if(othercardsArray.count==2&&self.gameplaymode==3)
                        {
                            self.score-=MISMATCH_PENALITY;
                            for(Card *otherChoosenCard in othercardsArray)
                            {
                                otherChoosenCard.chosen=NO;
                            }
                            self.resultString=[matchResultInfo objectAtIndex:1];
                        }
                    }
                    if(self.gameplaymode==2)
                        break;
                    if(othercardsArray.count==2&&self.gameplaymode==3)
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

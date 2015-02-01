//
//  Card.m
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize contents=_contents,chosen=_chosen,matched=_matched;
-(int)match:(NSArray *)othercards
{
    int score=0;
    for (Card *card in othercards) {
        if([card.contents isEqualToString:self.contents])
        {
            score=1;
        }
    }
    return score;
}
@end

//
//  ViewController.m
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
@interface ViewController ()

@property(nonatomic,strong)CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ViewController

-(CardMatchingGame *)game
{
    if(!_game)
    {
        _game=[[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
    }
    return _game;
}
-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}
- (IBAction)touchCardButton:(UIButton *)sender {
    int choosenButtonIndex=[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    [self updateUI];
}
-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        int cardButtonIndex=[self.cardButtons indexOfObject:cardButton];
        Card *card=[_game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled=!card.isMatched;
        self.scoreLabel.text=[NSString stringWithFormat:@"Score: %d",_game.score];
    }
    
}
- (IBAction)resetGameButton:(UIButton *)sender {
    _game=nil;
    for(UIButton *button in self.cardButtons)
    {
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setEnabled:YES];
        [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
         
    }
}
-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen?card.contents:@"";
}
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}
@end

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
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayModeSegment;
@property (weak, nonatomic) IBOutlet UILabel *resultStringLabel;
@end

@implementation ViewController

-(CardMatchingGame *)game
{
    if(!_game)
    {
        _game=[[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
        if(self.gamePlayModeSegment.selectedSegmentIndex==0)
        {
            _game.gameplaymode=2;
        }
        else if(self.gamePlayModeSegment.selectedSegmentIndex==1)
        {
            _game.gameplaymode=3;
        }
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
//     NSLog(@"%@",_game.resultString);
    self.resultStringLabel.text=_game.resultString;
    
}
- (IBAction)resetGameButton:(UIButton *)sender {
    _game=nil;
      _gamePlayModeSegment.enabled=YES;
    for(UIButton *button in self.cardButtons)
    {
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setEnabled:YES];
        [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
         
    }
    self.scoreLabel.text=@"Score: 0";
    self.resultStringLabel.text=@"";
}
-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen?card.contents:@"";
}
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}
- (IBAction)gamePlayModeChanged:(UISegmentedControl *)sender {
    switch(sender.selectedSegmentIndex)
    {
        case 0:    _game.gameplaymode=2;
            break;
        case 1:_game.gameplaymode=3;
            break;
        default:_game.gameplaymode=2;
    }
}

@end

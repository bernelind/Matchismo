//
//  ViewController.m
//  Matchismo
//
//  Created by Sarah Bernelind on 02/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import "ViewController.h"
#import "deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *cards;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@end

@implementation ViewController


- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    //NSLog(@"create deck");
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSLog(@"touch card button");
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    NSLog(@"buttonindex: %d", chosenButtonIndex);
    [self.game chooseCardAtIndex:chosenButtonIndex];
    NSLog(@"out of chosenButtonIndex");
    [self updateUI];
    NSLog(@"UI updated");
    
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (IBAction)touchNewGameButton
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.scoreLabel.text = @"Score: 0";
    if(self.modeSwitch.isOn) {
        self.game.mode = 3;
    }
}


- (IBAction)ValueSwitch:(UISwitch *)sender
{
    if (sender.isOn) {
        self.game.mode = 3;
        self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[self createDeck]];
        for (UIButton *cardButton in self.cardButtons) {
            [cardButton setTitle:@"" forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                                  forState:UIControlStateNormal];
            cardButton.enabled = YES;
        }
        self.scoreLabel.text = @"Score: 0";
        if(self.modeSwitch.isOn) {
            self.game.mode = 3;
        }
        
    } else {
        self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[self createDeck]];
        for (UIButton *cardButton in self.cardButtons) {
            [cardButton setTitle:@"" forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                                  forState:UIControlStateNormal];
            cardButton.enabled = YES;
        }
        self.scoreLabel.text = @"Score: 0";
        if(self.modeSwitch.isOn) {
            self.game.mode = 3;
        }
        self.game.mode = 2;
    }
    

}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end

//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sarah Bernelind on 03/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Cards
@property (nonatomic, strong) NSMutableArray *otherCards; // when choosing several cards
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)otherCards
{
    if (!_otherCards) _otherCards = [[NSMutableArray alloc] init];
    return _otherCards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; // Super's designated initializer
    
    if(self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
                self.score = 0;
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    NSLog(@"choosecardatindex: start");
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            NSLog(@"bajs");
            card.chosen = NO;
        } else { // match against other chosen cards
            NSLog(@"match against other cards: start");
            if (self.mode == 3) { // if in 3-match mode
                if (!card.isChosen) {
                    card.chosen = YES;
                }
                int amount = 1;
                if (amount <= 3) {
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            NSLog(@"otherCards: %d", [self.otherCards count]);
                            if (![self.otherCards containsObject:otherCard]) {
                                [self.otherCards addObject:otherCard];
                                NSLog(@"addObject: success");
                                amount ++;
                            }
                        }
                    }
                    NSLog(@"before matchscore,othercards: %d", [self.otherCards count]);
                    if ([self.otherCards count]>2) {
                        int matchScore = [card match:self.otherCards];
                        //NSLog(@"after match: %d", matchScore);
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            for (Card *otherCard in self.otherCards) {
                                NSLog(@"the marked as matched for loop");
                                otherCard.matched = YES;
                            }
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            for (Card *otherCard in self.otherCards) {
                                otherCard.chosen = NO;
                                NSLog(@"mismatch");
                            }
                            [self.otherCards removeAllObjects];
                        }
                    }
                    
                }
                
            } else {

                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        NSLog(@"matchscore: %d", matchScore);
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                    }
                }

            }

            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            NSLog(@"sist");
        }
    }
    
}

@end

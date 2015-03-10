//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sarah Bernelind on 03/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//deisgnated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger mode;

@end

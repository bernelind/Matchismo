//
//  Deck.h
//  Matchismo
//
//  Created by Sarah Bernelind on 02/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end

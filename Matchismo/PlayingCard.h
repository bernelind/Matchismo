//
//  PlayingCard.h
//  Matchismo
//
//  Created by Sarah Bernelind on 02/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end

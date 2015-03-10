//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sarah Bernelind on 02/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

- (int)match:(NSMutableArray *)otherCards
{
    int score = 0;
    NSLog(@"othercards in match : %d", [otherCards count]);
    
    if ([otherCards count] == 1) { // in 2 card mode
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if([otherCards count] == 3) { // in 3 card mode
//        NSMutableArray *otherCardsCopy = [otherCards copy];
//        for (PlayingCard *copy in otherCardsCopy){
//            if (copy.rank != self.rank && ![copy.suit isEqualToString:self.suit]) {
//                
//                [otherCards removeObject:self];
//            }
//        }
//        [otherCardsCopy release];
        PlayingCard *temp = [otherCards lastObject];
        NSLog(@"Removelastobject: %@", temp.suit, temp.rank);
        [otherCards removeLastObject];
        for (PlayingCard *otherCard in otherCards) {
            NSLog(@"for each playingcard in othercard");

            if (otherCard.rank == self.rank) {
                score += 4;
            }
            if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
            }
            NSLog(@"after first for-loop: %d", score);
        }
        PlayingCard *otherCard = [otherCards firstObject];
        PlayingCard *secondCard = [otherCards lastObject];
        NSLog(@"othercard: %@", otherCard.suit, otherCard.rank);
        NSLog(@"secondcard: %@", secondCard.suit, secondCard.rank);
        if (otherCard.rank == secondCard.rank) {
            score += 4;
        }
        if ([otherCard.suit isEqualToString:secondCard.suit]) {
            score += 1;
        }
        NSLog(@"after second for-loop: %d", score);
    }
    return score;
}

- (NSString *)contents;
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
+ (NSArray *)validSuits
{
    return @[@"♥️",@"♦️",@"♠️",@"♣️"];
}
- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1;}
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}
@end

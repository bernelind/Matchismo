//
//  Card.h
//  Matchismo
//
//  Created by Sarah Bernelind on 02/03/15.
//  Copyright (c) 2015 Sarah Bernelind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end

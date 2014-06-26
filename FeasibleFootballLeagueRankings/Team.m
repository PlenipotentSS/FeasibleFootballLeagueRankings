//
//  Team.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "Team.h"

@implementation Team

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gamesLost = 0;
        _gamesTied = 0;
        _gamesWon = 0;
    }
    return self;
}

-(instancetype)initWithName:(NSString*)name
{
    self = [self init];
    if (self) {
        _name = name;
    }
    return self;
}


/*
 * Score = 2 * NUM_WINS + NUM_TIES
 */
- (NSInteger)currentRankedScore
{
    return 2*self.gamesWon + self.gamesTied;
}

@end

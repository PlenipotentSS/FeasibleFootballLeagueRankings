//
//  Game.h
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

typedef enum : NSUInteger {
    GameResultHomeTeamWon,
    GameResultAwayTeamWon,
    GameResultGameTied
} GameResult;

@interface Game : NSObject

/// Team that is currently at home
@property (nonatomic,weak) Team *homeTeam;

/// Team that is currently away
@property (nonatomic,weak) Team *awayTeam;

/// Reference to the winning team
@property (nonatomic) GameResult gameResult;

/// Convenience initializer with home and away teams
- (instancetype)initWithHomeTeam:(Team*)homeTeam andAwayTeam:(Team*)awayTeam;

/// Add this game's result to compute winner or tie;
///     Returns Game Result state
- (GameResult)inputGameResultWithHomeScore:(NSInteger)homeScore andAwayScore:(NSInteger)awayScore;

/// Update homeTeam and awayTeam with result and return the given result.
///     Return Game Result state
- (GameResult)updateGameTeamsAndGetResultWithHomeScore:(NSInteger)homeScore andAwayScore:(NSInteger)awayScore;

@end

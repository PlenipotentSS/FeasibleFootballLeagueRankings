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

/// team that is currently at home
@property (nonatomic,weak) Team *homeTeam;

/// team that is currently away
@property (nonatomic,weak) Team *awayTeam;

/// reference to the winning team
@property (nonatomic) GameResult gameResult;

/// convenience initializer with home and away teams
- (instancetype)initWithHomeTeam:(Team*)homeTeam andAwayTeam:(Team*)awayTeam;

/// add this game's result to compute winner or tie;
- (GameResult)inputGameResultWithHomeScore:(NSInteger)homeScore andAwayScore:(NSInteger)awayScore;

/// update homeTeam and awayTeam with result and return the given result.
- (GameResult)updateGameTeamsAndGetResultWithHomeScore:(NSInteger)homeScore andAwayScore:(NSInteger)awayScore;

@end

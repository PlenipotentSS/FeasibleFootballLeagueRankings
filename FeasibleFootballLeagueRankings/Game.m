//
//  Game.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "Game.h"
@interface Game ()

/// score for the home team
@property (nonatomic) NSInteger homeScore;

/// score for the away team
@property (nonatomic) NSInteger awayScore;

@end

@implementation Game

- (instancetype)init
{
    self = [super init];
    if (self) {
        _homeTeam = [Team new];
        _awayTeam = [Team new];
        _homeScore = 0;
        _awayScore = 0;
    }
    return self;
}

- (instancetype)initWithHomeTeam:(Team *)homeTeam andAwayTeam:(Team *)awayTeam
{
    self = [super init];
    if (self) {
        _homeTeam = homeTeam;
        _awayTeam = awayTeam;
    }
    return self;
}

- (GameResult)inputGameResultWithHomeScore:(NSInteger)homeScore andAwayScore:(NSInteger)awayScore
{
    GameResult result;
    if ( homeScore > awayScore ) {
        result = GameResultHomeTeamWon;
    } else if ( homeScore == awayScore ) {
        result = GameResultGameTied;
    } else {
        result = GameResultAwayTeamWon;
    }
    
    return result;
}

@end

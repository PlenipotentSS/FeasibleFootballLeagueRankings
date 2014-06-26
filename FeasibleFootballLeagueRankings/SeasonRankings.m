//
//  SeasonRankings.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "SeasonRankings.h"

@interface SeasonRankings ()

///list of all current teams
@property (nonatomic, strong) NSMutableArray *teams;

///results of all games played
@property (nonatomic, strong) NSMutableArray *gameResults;

@end

@implementation SeasonRankings

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gameResults = [NSMutableArray new];
    }
    return self;
}

- (BOOL)processGamesFromPathString:(NSString *)pathString
{
    return NO;
}

- (void)printGameResults
{
    
}

- (BOOL)saveGameResultsToFile:(NSString *)savedPathString
{
    return NO;
}

@end

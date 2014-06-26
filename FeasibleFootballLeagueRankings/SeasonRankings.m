//
//  SeasonRankings.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "SeasonRankings.h"
#import "Game.h"

@interface SeasonRankings ()

///list of all current teams
@property (nonatomic, strong) NSMutableDictionary *teams;

///results of all games played
@property (nonatomic, strong) NSMutableArray *gameResults;


///results of all games played
@property (nonatomic, strong) NSMutableArray *currentRankings;

@end

@implementation SeasonRankings

- (instancetype)init
{
    self = [super init];
    if (self) {
        _teams = [NSMutableDictionary new];
        _gameResults = [NSMutableArray new];
    }
    return self;
}

- (BOOL)didProcessGamesFromPathString:(NSString *)pathString
{
    pathString = [pathString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSError *err;
    NSString *content = [NSString stringWithContentsOfFile:pathString
                                                  encoding:NSUTF8StringEncoding
                                                     error:&err];
    if (!err) {
        
        //games by line
        NSArray *games = [content componentsSeparatedByString:@"\n"];
        for( NSString *game in games) {
            NSArray *teamAndScores = [game componentsSeparatedByString:@", "];
            NSMutableArray *teams = [[NSMutableArray alloc] initWithCapacity:2];
            NSMutableArray *scores = [[NSMutableArray alloc] initWithCapacity:2];
            
            //teams for each game
            for (NSString *homeAndAway in teamAndScores) {
                NSArray *teamComponents = [homeAndAway componentsSeparatedByString:@" "];
                NSString *name;
                
                //keep white space if it is contained in name
                if ( [teamComponents count] > 2) {
                    NSRange range;
                    range.location = 0;
                    range.length = [teamComponents count]-1;
                    
                    NSArray *nameComponents = [teamComponents subarrayWithRange:range];
                    name = [nameComponents componentsJoinedByString:@" "];
                } else {
                    name = teamComponents[0];
                }
                NSInteger score = [teamComponents[[teamComponents count]-1] integerValue];
                
                //see if we have team in dictionary
                Team *thisTeam = [self.teams objectForKey:name];
                if (!thisTeam) {
                    thisTeam = [[Team alloc] initWithName:name];
                    [self.teams setObject:thisTeam forKey:name];
                }
                
                //prepare teams and scores to game
                [teams addObject:thisTeam];
                [scores addObject:@(score)];
            }
            
            //add teams and scores to this game
            Game *thisGame = [[Game alloc] initWithHomeTeam:teams[0] andAwayTeam:teams[1]];
            [thisGame updateGameTeamsAndGetResultWithHomeScore:[scores[0] integerValue] andAwayScore:[scores[1] integerValue]];
            [self.gameResults addObject:thisGame];
        }
        
        return YES;
    } else {
        return NO;
    }
}

- (void)calculateRankings
{
    _currentRankings = [[NSMutableArray alloc] init];
    
    for (NSString *teamName in [self.teams allKeys]) {
        Team *thisTeam = [self.teams objectForKey:teamName];
        
        //find index to put current team to ensure rankedScore is at highest index
        NSInteger i=0;
        for (; i< [self.currentRankings count]; i++) {
            Team *storedTeam = (Team*)[self.currentRankings objectAtIndex:i];
            NSInteger storedTeamRankedScore = [storedTeam currentRankedScore];
            NSInteger thisTeamRankedScore = [thisTeam currentRankedScore];
            
            if (storedTeamRankedScore < thisTeamRankedScore) {
                break;
            } else if ( storedTeamRankedScore == thisTeamRankedScore ) {
                NSComparisonResult comparedTeamNameResult = [thisTeam.name compare:storedTeam.name];
                if (comparedTeamNameResult == NSOrderedAscending) {
                    break;
                }
            }
        }
        
        //add to current rankings
        if ([self.currentRankings count] == i) {
            [self.currentRankings addObject:thisTeam];
        } else {
            [self.currentRankings insertObject:thisTeam atIndex:i];
        }
    }
}

- (void)printSeasonRankings
{
    NSString *result = @"";
    NSInteger rank = 1;
    NSInteger previousScore = 0;
    NSInteger skippedRanks = 0;
    for (Team *ranking in self.currentRankings) {
        NSInteger thisTeamsScore = [ranking currentRankedScore];
        if (previousScore == thisTeamsScore) {
            skippedRanks++;
        } else {
            skippedRanks = 0;
        }
        
        NSString *points = (thisTeamsScore == 1) ? @"pt" : @"pts";
        points = [NSString stringWithFormat:@"%ld %@",thisTeamsScore, points];
        
        NSInteger thisRank = rank-skippedRanks;
        result = [NSString stringWithFormat:@"%@%ld. %@, %@\n",result,thisRank,ranking.name,points];
        
        previousScore = thisTeamsScore;
        rank++;
    }
    NSLog(@"\n%@",result);
}

- (BOOL)saveRankingsToFile:(NSString *)savedPathString
{
    savedPathString = [savedPathString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return NO;
}



@end

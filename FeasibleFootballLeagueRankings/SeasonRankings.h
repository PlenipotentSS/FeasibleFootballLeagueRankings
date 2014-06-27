//
//  SeasonRankings.h
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeasonRankings : NSObject

/// Process game from file
///     Assumptions: File is well formed
///     Returns: True if file was successfully read, false otherwise
- (BOOL)didProcessGamesFromPathString:(NSString*)pathString;

/// Calculate Rankings  for this season
///     Assumptions: didProcessGamesFromPathString:(NSString*)
///         was called previously
- (void)calculateRankings;

/// Get command line friendly string (char*) of current rankings
///     Return char* of results
- (char*)getSeasonRankings;

/// Save the current rankings to file
///     Assumptions: savedPathString is absolute file path
///         All relative files paths will be stored in app environment
- (BOOL)saveRankingsToFile:(NSString*)savedPathString;

/// Return the total teams in this season
- (NSInteger)totalTeams;

/// Return the total rankings in this season
///     Note: will be 0 until rankings have been calculated.
- (NSInteger)totalRankings;

@end

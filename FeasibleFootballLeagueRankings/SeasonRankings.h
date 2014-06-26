//
//  SeasonRankings.h
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeasonRankings : NSObject

- (BOOL)processGamesFromPathString:(NSString*)pathString;

- (void)printGameResults;

- (BOOL)saveGameResultsToFile:(NSString*)savedPathString;

@end

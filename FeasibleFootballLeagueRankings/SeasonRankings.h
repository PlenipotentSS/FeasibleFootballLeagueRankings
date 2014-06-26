//
//  SeasonRankings.h
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeasonRankings : NSObject

- (BOOL)didProcessGamesFromPathString:(NSString*)pathString;

- (void)calculateRankings;

- (void)printSeasonRankings;

- (BOOL)saveRankingsToFile:(NSString*)savedPathString;

@end

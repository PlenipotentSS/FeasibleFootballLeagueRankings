//
//  Team.h
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

/// Current name of team
@property (nonatomic, strong) NSString *name;

/// Games won for this team
@property (nonatomic) NSInteger gamesWon;

/// Games tied for this team
@property (nonatomic) NSInteger gamesTied;

/// Games lost for this team
@property (nonatomic) NSInteger gamesLost;

/// Convenience initializer for name
-(instancetype)initWithName:(NSString*)name;

/// Computed score for team
- (NSInteger)currentRankedScore;

@end

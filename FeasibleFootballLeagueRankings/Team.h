//
//  Team.h
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

/// current name of team
@property (nonatomic, strong) NSString *name;

/// games won for this team
@property (nonatomic) NSInteger gamesWon;

/// games tied for this team
@property (nonatomic) NSInteger gamesTied;

/// games lost for this team
@property (nonatomic) NSInteger gamesLost;

/// convenience initializer for name
-(instancetype)initWithName:(NSString*)name;

///computed score for team
- (NSInteger)currentRankedScore;

@end

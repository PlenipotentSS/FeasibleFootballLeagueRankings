//
//  FeasibleFootballRankingsTeamTests.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 7/1/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Team.h"

__attribute__((visibility("default"))) @interface FeasibleFootballLeagueRankingsTeam_Tests : XCTestCase

/// placeholder for team A for testing
@property (nonatomic, strong) Team *teamA;

/// placeholder for team A for testing
@property (nonatomic, strong) Team *teamB;

@end

@implementation FeasibleFootballLeagueRankingsTeam_Tests

- (void)setUp
{
    [super setUp];
    
    self.teamA = [[Team alloc] initWithName:@"Sounders FC"];
    
    self.teamB = [[Team alloc] initWithName:@"Bayer Munich"];
}

- (void)tearDown
{
    self.teamA = nil;
    
    self.teamB = nil;
    
    [super tearDown];
}

/// Test Basic Team Setup
- (void)testBasicTeamSetup
{
    Team *aTeam = [Team new];
    XCTAssertNotNil(aTeam, @"Team initialization not nil");
    XCTAssertNil(aTeam.name, @"Team created without name should have nil name");
    
    [aTeam setName:@"Manchester United"];
    XCTAssertNotNil([aTeam name], @"Team name should not be nil after setting");
    
    XCTAssertEqual(aTeam.gamesTied, 0, @"A team should start out with 0 games tied");
    XCTAssertEqual(aTeam.gamesLost, 0, @"A team should start out with 0 games tied");
    XCTAssertEqual(aTeam.gamesWon, 0, @"A team should start out with 0 games tied");
    
    [aTeam setGamesWon:5];
    [aTeam setGamesLost:5];
    
    XCTAssertEqual(aTeam.gamesWon, aTeam.gamesLost, @"Team should have same number of games won and lost when set with same value");
    
    [aTeam setGamesTied:2];
    XCTAssertEqual(aTeam.gamesTied, 2, @"value of games tied should be same as literal type of same value");
    
    XCTAssertNotEqual([aTeam currentRankedScore], [self.teamA currentRankedScore], @"comparing team with score and no score should not have the same current score");
}

/// Test Basic Team Comparisons and Expected Values
- (void)testTeamComparisons
{
    
    // test games won across two teams
    self.teamA.gamesWon = 5;
    self.teamB.gamesWon = 5;
    XCTAssertEqual(self.teamA.gamesWon, self.teamB.gamesWon, @"Two Teams should have same games won if set with same");
    XCTAssertEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"two teams with same amount of wins should have same score");
    
    //test games lost across two teams
    self.teamA.gamesLost = 3;
    self.teamB.gamesLost = 2;
    XCTAssertNotEqual(self.teamA.gamesLost, self.teamB.gamesLost, @"Two teams with different games lost cannot be the same if set with different amounts");
    XCTAssertEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"Two teams with same games won and different games los should have the same score");
    
    //test games tied across two teams
    self.teamA.gamesTied = 4;
    self.teamB.gamesTied = 5;
    XCTAssertNotEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"Two teams with same games won and different games tied should not have the same score");
    
    //test if games tied can pull a equal ranking
    self.teamA.gamesTied += 1;
    XCTAssertEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"increasing Games tied for losing team (-1 differential) should now be tied with other team");
    
    //test if teams are tied, losing does not affect ranking
    self.teamB.gamesLost += 1;
    XCTAssertEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"increasing games lost should not affect team score");
}



@end

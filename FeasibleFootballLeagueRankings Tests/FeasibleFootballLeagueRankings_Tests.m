//
//  FeasibleFootballLeagueRankings_Tests.m
//  FeasibleFootballLeagueRankings Tests
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Team.h"
#import "Game.h"

__attribute__((visibility("default"))) @interface FeasibleFootballLeagueRankings_Tests : XCTestCase

/// placeholder for team A for testing
@property (nonatomic, strong) Team *teamA;

/// placeholder for team A for testing
@property (nonatomic, strong) Team *teamB;


@end

@implementation FeasibleFootballLeagueRankings_Tests

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
    
    XCTAssertNotEqual([aTeam currentScore], [self.teamA currentScore], @"comparing team with score and no score should not have the same current score");
}

- (void)testTeamComparisons
{

    
    self.teamA.gamesWon = 5;
    self.teamB.gamesWon = 5;
    
    XCTAssertEqual(self.teamA.gamesWon, self.teamB.gamesWon, @"Two Teams should have same games won if set with same");
    
    XCTAssertEqual([self.teamA currentScore], [self.teamB currentScore], @"two teams with same amount of wins should have same score");
    
    self.teamA.gamesLost = 3;
    self.teamB.gamesLost = 2;
    XCTAssertNotEqual(self.teamA.gamesLost, self.teamB.gamesLost, @"Two teams with different games lost cannot be the same if set with different amounts");
    
    XCTAssertEqual([self.teamA currentScore], [self.teamB currentScore], @"Two teams with same games won and different games los should have the same score");
    
    self.teamA.gamesTied = 4;
    self.teamB.gamesTied = 5;
    XCTAssertNotEqual([self.teamA currentScore], [self.teamB currentScore], @"Two teams with same games won and different games tied should not have the same score");
    
    self.teamA.gamesTied += 1;
    XCTAssertEqual([self.teamA currentScore], [self.teamB currentScore], @"increasing Games tied for losing team (-1 differential) should now be tied with other team");
    
    self.teamB.gamesLost += 1;
    XCTAssertEqual([self.teamA currentScore], [self.teamB currentScore], @"increasing games lost should not affect team score");
}

- (void)testGameResults
{
    XCTAssertFalse(GameResultAwayTeamWon == GameResultHomeTeamWon, @"Game results of Home Win and Away Win should not be equal");
    XCTAssertFalse(GameResultHomeTeamWon == GameResultGameTied, @"Home Team Win and Tie are not the same game result");
    XCTAssertFalse(GameResultAwayTeamWon == GameResultGameTied, @"Away Team Win and Tie are not the same game result");
}

- (void)testGames
{
    
    Game *firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    XCTAssertNotNil(firstMatch, @"creating first match with teams should not be nil");
    XCTAssertNotNil(firstMatch.homeTeam, @"home team should not be nil");
    XCTAssertNotNil(firstMatch.awayTeam, @"away team should not be nil");
    
    XCTAssertTrue(firstMatch.gameResult == 0, @"game result should be 0 if game input has not been recorded");
    
    
    [firstMatch inputGameResultWithHomeScore:3 andAwayScore:2];
    XCTAssertTrue(firstMatch.gameResult == GameResultHomeTeamWon, @"Game results with Home Team Win");
    
    firstMatch = nil;
    firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    [firstMatch inputGameResultWithHomeScore:2 andAwayScore:3];
    XCTAssertTrue(firstMatch.gameResult == GameResultHomeTeamWon, @"Game results with Away Team Win");
    
    firstMatch = nil;
    firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    [firstMatch inputGameResultWithHomeScore:2 andAwayScore:2];
    XCTAssertTrue(firstMatch.gameResult == GameResultHomeTeamWon, @"Game results with Tie");
}

@end

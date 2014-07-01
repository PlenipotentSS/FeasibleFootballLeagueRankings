//
//  FeasibleFootballRankingsGames_Tests.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 7/1/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Team.h"
#import "Game.h"

__attribute__((visibility("default"))) @interface FeasibleFootballLeagueRankingsGames_Tests : XCTestCase

/// placeholder for team A for testing
@property (nonatomic, strong) Team *teamA;

/// placeholder for team A for testing
@property (nonatomic, strong) Team *teamB;

@end

@implementation FeasibleFootballLeagueRankingsGames_Tests

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

/// Test All Game Result States are different from each other
- (void)testGameResultsStates
{
    XCTAssertFalse(GameResultAwayTeamWon == GameResultHomeTeamWon, @"Game results of Home Win and Away Win should not be equal");
    XCTAssertFalse(GameResultHomeTeamWon == GameResultGameTied, @"Home Team Win and Tie are not the same game result");
    XCTAssertFalse(GameResultAwayTeamWon == GameResultGameTied, @"Away Team Win and Tie are not the same game result");
}

/// Test Basic Game Setup
- (void)testGameSetup
{
    Game *firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    XCTAssertNotNil(firstMatch, @"creating first match with teams should not be nil");
    XCTAssertNotNil(firstMatch.homeTeam, @"home team should not be nil");
    XCTAssertNotNil(firstMatch.awayTeam, @"away team should not be nil");
}

/// Testing Games with Results only, without updating team stats
- (void)testGamesWithJustResults
{
    
    Game *firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    XCTAssertNotNil(firstMatch, @"creating first match with teams should not be nil");
    XCTAssertNotNil(firstMatch.homeTeam, @"home team should not be nil");
    XCTAssertNotNil(firstMatch.awayTeam, @"away team should not be nil");
    
    XCTAssertTrue(firstMatch.gameResult == 0, @"game result should be 0 if game input has not been recorded");
    
    
    [firstMatch inputGameResultWithHomeScore:3 andAwayScore:2];
    XCTAssertTrue(firstMatch.gameResult == GameResultHomeTeamWon, @"Game results should have Home Team Win");
    
    firstMatch = nil;
    firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    [firstMatch inputGameResultWithHomeScore:2 andAwayScore:3];
    XCTAssertTrue(firstMatch.gameResult == GameResultAwayTeamWon, @"Game results should have Away Team Win");
    
    firstMatch = nil;
    firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    [firstMatch inputGameResultWithHomeScore:2 andAwayScore:2];
    XCTAssertTrue(firstMatch.gameResult == GameResultGameTied, @"Game results should have Tie");
}

/// Test Game can update team ranking scores referenced in the game results
- (void)testGamesWithResultsAndUpdatingTeams
{
    //test when home team wins first game and both teams are updated
    Game *firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    NSInteger initialHomeScore = [self.teamA currentRankedScore];
    NSInteger initialAwayScore = [self.teamB currentRankedScore];
    
    XCTAssertEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"Home and Away team should have same score with their first match");
    
    [firstMatch updateGameTeamsAndGetResultWithHomeScore:5 andAwayScore:4];
    XCTAssertEqual([self.teamA currentRankedScore], [firstMatch.homeTeam currentRankedScore], @"home team and teamA (referened as home) should have same score after match");
    XCTAssertEqual([self.teamA currentRankedScore], [firstMatch.homeTeam currentRankedScore], @"away team and teamB (referened as away) should have same score after match");
    
    XCTAssertEqual([self.teamA currentRankedScore], 3+initialHomeScore, @"Home team score should be 3 points more");
    XCTAssertEqual([self.teamB currentRankedScore], initialAwayScore, @"Away Team should have same score with a loss");
    
    XCTAssertTrue([self.teamA currentRankedScore] > [self.teamB currentRankedScore], @"Home Team should have higher score over away team");
    
    
    //test when away team wins and balances out the two teams scores
    Game *secondMatch = [[Game alloc] initWithHomeTeam:self.teamB andAwayTeam:self.teamA];
    XCTAssertTrue([self.teamA currentRankedScore] > [self.teamB currentRankedScore], @"Teams swapped home and away, but their score's should still show the same score");
    
    [secondMatch updateGameTeamsAndGetResultWithHomeScore:3 andAwayScore:2];
    XCTAssertTrue([self.teamA currentRankedScore] == [self.teamB currentRankedScore], @"");
    
    
    //test if they tie, and they remain equal in ranking score.
    NSInteger preThirdMatchHomeScore = [self.teamA currentRankedScore];
    NSInteger preThirdMatchAwayScore = [self.teamB currentRankedScore];
    
    Game *thirdMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    [thirdMatch updateGameTeamsAndGetResultWithHomeScore:1 andAwayScore:1];
    XCTAssertTrue([self.teamA currentRankedScore] == [self.teamB currentRankedScore], @"teams that were tied before a tie result should still be tied");
    XCTAssert(preThirdMatchHomeScore + 1 == [self.teamA currentRankedScore], @"a tie should add only 1 score to home team");
    XCTAssert(preThirdMatchAwayScore + 1 == [self.teamB currentRankedScore], @"a tie should add only 1 score to away team");
    XCTAssertEqual([self.teamA currentRankedScore], [self.teamB currentRankedScore], @"increasing games lost should not affect team score");
}



@end

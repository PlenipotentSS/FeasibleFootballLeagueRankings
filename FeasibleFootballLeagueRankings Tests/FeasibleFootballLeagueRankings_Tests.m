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

/// Basic team setup
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

/// Team models can be compared together and report appropriate information
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

/// All game results are different from each other
- (void)testGameResultsStates
{
    XCTAssertFalse(GameResultAwayTeamWon == GameResultHomeTeamWon, @"Game results of Home Win and Away Win should not be equal");
    XCTAssertFalse(GameResultHomeTeamWon == GameResultGameTied, @"Home Team Win and Tie are not the same game result");
    XCTAssertFalse(GameResultAwayTeamWon == GameResultGameTied, @"Away Team Win and Tie are not the same game result");
}

/// Basic game setup
- (void)testGameSetup
{
    Game *firstMatch = [[Game alloc] initWithHomeTeam:self.teamA andAwayTeam:self.teamB];
    
    XCTAssertNotNil(firstMatch, @"creating first match with teams should not be nil");
    XCTAssertNotNil(firstMatch.homeTeam, @"home team should not be nil");
    XCTAssertNotNil(firstMatch.awayTeam, @"away team should not be nil");
}

/// Game results are returned as expected
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

/// Game can update team ranking scores referenced in the game results
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
    
    XCTAssertNotEqual([self.teamA currentRankedScore], initialHomeScore, @"Home team score should be different after a game without a tie");
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
}

@end

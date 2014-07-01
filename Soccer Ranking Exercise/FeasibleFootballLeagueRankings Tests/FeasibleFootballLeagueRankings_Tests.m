//
//  FeasibleFootballLeagueRankings_Tests.m
//  FeasibleFootballLeagueRankings Tests
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SeasonRankings.h"

__attribute__((visibility("default"))) @interface FeasibleFootballLeagueRankings_Tests : XCTestCase

@end

@implementation FeasibleFootballLeagueRankings_Tests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

/// Test Season Rankings Setup
- (void)testSeasonRankingsSetup
{
    SeasonRankings *season = [[SeasonRankings alloc] init];
    XCTAssertNotNil(season, @"creating instance of season does not create nil instance");
    
    //test for no input string to process games
    BOOL failedRead = [season didProcessGamesFromPathString:@""];
    XCTAssertFalse(failedRead, @"season should return false if processing Games from pathstring failed");
    
    NSString* testPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SampleInput" ofType:@"txt"];
    BOOL trueRead = [season didProcessGamesFromPathString:testPath];
    XCTAssertTrue(trueRead, @"season should return true if file path has expected file");
}

/// Test different inputs for ranking updates
- (void)testRankingsWithDifferentLists
{
    NSString* testPath1 = [[NSBundle bundleForClass:[self class]] pathForResource:@"SmallSampleData" ofType:@"txt"];
    [self testRankingsWithPath:testPath1];
    
    NSString* testPath2 = [[NSBundle bundleForClass:[self class]] pathForResource:@"SampleInput" ofType:@"txt"];
    [self testRankingsWithPath:testPath2];
    
    NSString* testPath3 = [[NSBundle bundleForClass:[self class]] pathForResource:@"BigSampleInput" ofType:@"txt"];
    [self testRankingsWithPath:testPath3];
}

/// Testing files at a given path, and ensure process is accurate
- (void)testRankingsWithPath:(NSString*)path
{
    SeasonRankings *season = [[SeasonRankings alloc] init];
    
    XCTAssertEqual([season totalTeams], 0, @"Total teams should be 0 after initalization");
    
    // file was successfully read from bundle
    BOOL trueRead = [season didProcessGamesFromPathString:path];
    XCTAssertTrue(trueRead, @"season should return true if file path has expected file");
    XCTAssertNotEqual([season totalTeams], 0, @"Total teams should not be 0 after processing file");
    XCTAssertTrue([season totalRankings] == 0, @"total rankings before getting rankings should be 0");
    
    char* preResults = [season getSeasonRankings];
    XCTAssertTrue(strlen(preResults) == 0, @"results of rankings should have empty char before calculating rankings");
    
    [season calculateRankings];
    
    char* postResults = [season getSeasonRankings];
    XCTAssertFalse(strlen(postResults) == 0, @"results of rankings should not be nil after updating games");
    XCTAssertTrue([season totalRankings] == [season totalTeams], @"total rankings after getting rankings should be same as number of teams");
    
    // Saving File was successful
    NSString *savePath = @"savingTestFile.txt";
    BOOL trueWrite = [season saveRankingsToFile:savePath];
    XCTAssertTrue(trueWrite, @"rankings should be able to write to file");
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:savePath error:&error];
}

@end

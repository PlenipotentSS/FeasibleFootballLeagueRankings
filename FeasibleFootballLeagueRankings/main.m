//
//  main.m
//  FeasibleFootballLeagueRankings
//
//  Created by Stevenson on 6/26/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeasonRankings.h"

#define MAX_CHAR_SIZE 1024

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        char str[MAX_CHAR_SIZE] = ""; bool pathFound = false; bool exitApp = false;
        SeasonRankings *season;
        
        while (!exitApp) {
            char printYesNo[3] = ""; char saveYesNo[3] = ""; char leave[3] = "";
            
            //get file path
            while (!pathFound) {
                season = [[SeasonRankings alloc] init];
                
                printf("Enter input file path: \n");
                fgets(str, MAX_CHAR_SIZE, stdin);
                printf("looking for file at:\n\t%s\n",str);
                if ( [season didProcessGamesFromPathString:[NSString stringWithUTF8String:str]]) {
                    
                    printf("===========SUCCESS!===========\n\n");
                    pathFound = true;
                } else {
                    printf("There was an error with that file or filepath, please check again \n\n");
                }
            }
            
            //calculate the rankings...
            [season calculateRankings];
            
            //ask to print to log
            printf("would you like me to print results (Y/N)?");
            fgets(printYesNo, 3, stdin);
            if (printYesNo[0] == 'Y' || printYesNo[0] == 'y') {
                printf("%s", [season getSeasonRankings] );
            } else if (printYesNo[0] != 'N' && printYesNo[0] != 'n') {
                printf("huh?");
            }
            
            //ask to save to file
            printf("would you like me to save results (Y/N)?");
            fgets(saveYesNo, 3, stdin);
            if (saveYesNo[0] == 'Y' || saveYesNo[0] == 'y') {
                char savePath[MAX_CHAR_SIZE] = "";
                printf("Where would you like me to save it?");
                fgets(savePath, MAX_CHAR_SIZE, stdin);
                
                if ([season saveRankingsToFile:[NSString stringWithUTF8String:savePath]]) {
                    printf("Success!");
                } else {
                    printf("uh oh... There was an error writing to that path...");
                }
            } else if (saveYesNo[0] != 'N' && saveYesNo[0] != 'n') {
                printf("huh?");
            }
            
            //ask to quit
            printf("\nWant to Quit (Y (for yes)/ N (for no) / R (read new file))?");
            fgets(leave, 3, stdin);
            if (leave[0] == 'Y' || leave[0] == 'y') {
                exitApp = true;
            } else if (leave[0] == 'R' || leave[0] == 'r') {
                pathFound = false;
            }
        }
    }
    return 0;
}


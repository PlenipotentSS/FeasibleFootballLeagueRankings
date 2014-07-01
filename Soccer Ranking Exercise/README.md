### FeasibleFootballLeagueRankings

A Command Line tool that utilizes games stored in a well-formed text file and converts them into a ranking. 

There are two current builds in this repo. The Xcode project is dependent on xcode to run. This is the testing environment that utilizes XCTest class to unit test the different models of this project.

The executable build is a command line application stored in /Build/fflr

To use the executable build:

from containing directory:

```bash

	$ ./fflr [ARG 1] [ARG 2]
```

 - [ARG 1] is the path to the input file
 - [ARG 2] is the path to the output file (overwrites file at path by default)


Known Bugs:

1. Some Rankings do not print correctly in terminal with terminal interface. This is due to a lack of precision when converting ``NSString`` to ``char *``. However, rankings print perfectly when saved to file.
# Wolfram
A second-year student project that implements rules 30, 90, and 110 of Wolfram's elementary cellular automata in the terminal, coded using the Haskell programming language.

https://en.wikipedia.org/wiki/Elementary_cellular_automaton


## Usage

The program support the following options:
• --rule : the ruleset to use (30, 90, 110)
• --start : the generation number at which to start the display. The default value is 0.
• --lines : the number of lines to display. When omitted, the program never stops.
• --window : the number of cells to display on each line (line width). If even, the central cell is displayed in the next cell on the right. Default value is 80.
• --move : a translation to apply on the window. If negative, the window is translated to the left. If positive, it’s translated to the right.

If no option or invalid options are provided the program return 84 and display a usage message


## Build on Linux (Ubuntu)

### 1. Install the dependencies:

	curl -sSL https://get.haskellstack.org/ | sh

### 2. Build Wolfram from my repo:
	make
	./wolfram --rule 30 --lines 20 (example)


## Screenshots

![Alt text](screenshots/1.png?raw=true "1")
![Alt text](screenshots/2.png?raw=true "2")
![Alt text](screenshots/3.png?raw=true "3")
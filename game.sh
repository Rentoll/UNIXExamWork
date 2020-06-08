#!/bin/bash

#Range for random numbers
RANGE=10
WINRANGE=100

CHANCE_FOR_WIN=20
MAX_WIN_IN_ROW=2

#colours for output

RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
WHITE='\033[1;37m'
#No colour at all
NC='\033[0m'

#Images for output
LOSE_IMAGE="lose.png"
WIN_IMAGE="win.png"

#Print numbers in different colours
useColour () {
	case $1 in
		0)
		printf "${RED}$1${NC} "
		;;
		1)
		printf "${GREEN}$1${NC} "
		;;
		2)
		printf "${BROWN}$1${NC} "
		;;
		3)
		printf "${BLUE}$1${NC} "
		;;
		4)
		printf "${PURPLE}$1${NC} "
		;;
		5)
		printf "${CYAN}$1${NC} "
		;;
		6)
		printf "${GRAY}$1${NC} "
		;;
		7)
		printf "${YELLOW}$1${NC} "
		;;
		8)
		printf "${LIGHTBLUE}$1${NC} "
		;;
		9)
		printf "${WHITE}$1${NC} "
		;;
	esac
}

printNumbers () {
	useColour "$first"
	useColour "$second"
	useColour "$third"
	echo ""
}

winCondition () {
	first=$RANDOM
	let "first %= $RANGE"
	second=$first
	third=$second
	winsInRow=$((winsInRow+1))
	printNumbers
	tiv $WIN_IMAGE
	openImageInViewer "$WIN_IMAGE"
}

loseCondition () {
	first=$RANDOM
     	let "first %= $RANGE"
        second=$RANDOM
        let "second %= $RANGE"
        third=$RANDOM
        let "third %= $RANGE"
	winsInRow=0
	printNumbers
	tiv $LOSE_IMAGE
	openImageInViewer "$LOSE_IMAGE"
}

openImageInViewer () {
	echo "Do you like to open this image in viewer? Y to open, any key to continue"
	read input
	if [[ "$input" = "Y"  ]]; then
		fim -a $1
	fi
}

generateNumbers () {
	win=$RANDOM
	let "win %= WINRANGE"
	if [[ win -le CHANCE_FOR_WIN ]] && [[ winsInRow -le MAX_WIN_IN_ROW ]]; then
		winCondition
	else
		loseCondition
	fi
}

curl -s http://www.openyonated.com/wp-content/uploads/2011/12/Winning-FL-Rental-Offer-300x300.jpg > win.png
curl -s https://quantlabs.net/blog/wp-content/uploads/2017/07/Losing-it-all-600x300.jpg > lose.png
echo "Welcome to the game!"
winsInRow=0
while [ true ]
do
	echo "To exit print q, to spin just press enter"
	read input
	clear
	if [[ "$input" = "q" ]]; then
		break
	else
		generateNumbers
	fi
done

#! /usr/bin/perl
#...........................................................................
# MineSweeper
# ===========

# ####_"Half Hour" Minesweeper, and then all the rest..._
#
# The classic Minesweeper game has shipped with windows forever. This is a 
# "just because" version for ANSI terminal. I will not work very pleasantly
# on widows in the "Command Prompt" now but I may fix that. You will
# see the ANSI control sequences for the colored text. Look for a branch
# without ANSI color if you want to use "Command Prompt".
#
# Change $height, $width and $bombs to make a more challenging game. 
#
# &copy; 2012 Frank Lyon Cox
#
# This program is free software; you can redistribute it and/or modify it 
# under the same terms as Perl itself, either Perl version 5.10.1 or, at 
# your option, any later version of Perl 5 you may have available.
#...........................................................................

use strict;
use warnings;
use Term::ANSIColor;
use Term::ReadKey;
use Scalar::Util qw(looks_like_number);

$| = 1;

# Change $height, $width and $bombs to make a more challenging game.
my $height = 5;
my $width = 4;
my $bombs = 3;

my $bombIcon = '*';

my @playground;
my @foreground;




if ($bombs > ($height * $width)) {
    print "**WOAH!**\n\$bombs can't be bigger that \$height times \$width\n which is ";
    printf "%d\n", $height * $width;
    exit;
}

init();
show();

my $done = 0;
while (not $done) {
    print "enter row and column as two numbers: >";
    my $line = <STDIN>;
    my $aref = parseLine($line);
    if ($aref->[0] < 0) {
        show();
        print "\n***********[BOOM!]*********\n";
        exit;
    }

    show();
}





#.....................................................
# init()
#
# initialize foreground and playground arrays and 
# place the bombs at the start of the game...
#.....................................................
sub init {
    # init playground
    for (my $h = 0; $h < $height; $h++) {
        for (my $w = 0; $w < $width; $w++) {
            $playground[$w][$h] = '.';
        }
    }

    # init foreground
    for (my $h = 0; $h < $height; $h++) {
        for (my $w = 0; $w < $width; $w++) {
            $foreground[$w][$h] = 'B';
        }
    }

    # randomly place the bombs
    my $done = 0;
    while ($done != $bombs) {
        my $place_x = int (rand($width));
        my $place_y = int (rand($height));

    #   print "try: \$playground[$place_x][$place_y] = ",$playground[$place_x][$place_y],"\n";

        if ($playground[$place_x][$place_y] eq '.') {
            $playground[$place_x][$place_y] = $bombIcon;
            $done++;
        }
    }

    # put numbers in any cell accent to one or more bombs 
    for (my $h = 0; $h < $height; $h++) {
        for (my $w = 0; $w < $width; $w++) {
            my $n = countUm([$w, $h]);
            if ($n) {
                $playground[$w][$h] = $n;
            }
        }
    }

}




#.....................................................
# coutUm(currentPoint)
#
# count the number of bombs in adjacent to currentPoint
# in the playground
#.....................................................
sub countUm {
    my $thisPoint = shift;

    my $count = 0;
    my $directions = [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]];
    for my $p (@$directions) {
        my $try = [$thisPoint->[0] + $p->[0], $thisPoint->[1] + $p->[1]];
#       print "try: @$try \n";
        if ($playground[$thisPoint->[0]][$thisPoint->[1]] eq $bombIcon) {
            return undef;
        }
        elsif (
                $try->[0] >= 0
            and $try->[1] >= 0
            and $try->[0] < $width 
            and $try->[1] < $height
            and $playground[$try->[0]][$try->[1]] eq $bombIcon
           ) {
            $count++;
        }
    }
    return $count == 0 ? "." : $count;
}




#.....................................................
# show()
#
# Display the current game board
#.....................................................
sub show {

    # check for a win first...
    my $win = 1;
    FOO:
    for (my $h = 0; $h < $height; $h++) {
        for (my $w = 0; $w < $width; $w++) {
            if ($playground[$w][$h] ne $bombIcon) {
                if ($foreground[$w][$h] eq 'B') {
                    $win = 0;
                    last FOO;
                }
            }

        }
    }

    if ($win) {

        # show everything...
        for (my $h = 0; $h < $height; $h++) {
            for (my $w = 0; $w < $width; $w++) {
                $foreground[$w][$h] = 'C';
            }
        }
    }    

    # print x labels first
    print "    ";
    for my $xl (0 .. $width -1) {
        printf ("%-2d " ,$xl); 
    }
    print "\n\n";
    for (my $h = 0; $h < $height; $h++) {
        printf ("%-2d  ", $h);
        for (my $w = 0; $w < $width; $w++) {
            if ($foreground[$w][$h] eq 'B') {
                print "X  ";
            }
            else {
                $playground[$w][$h] eq $bombIcon ? print "$playground[$w][$h]  "
                                                 : print "$playground[$w][$h]  ";
           }
        }
        print "\n";
    }

    if ($win) {
        print "\n***********[YOU WIN!]*********\n";
        exit;
    }
}






#.....................................................
# $arrayRef = parseLine(line)
#
# parse the input line and return the two numbers
# as and array ref or undef on error
#.....................................................
sub parseLine {
    my $ar = shift;
    chomp $ar;
    my ($x, $y) = split /\s+/, $ar;

    if (not looks_like_number($x)) {
        print "\nbye\n";
        exit;
    } 
    
    if ($playground[$x][$y] eq $bombIcon) {
        $foreground[$x][$y] = "C";
        return [-1]; # boom
    }
    elsif ($playground[$x][$y] =~ m/\./) {
#       print "    \$playground[$x][$y] = $playground[$x][$y] so \n";
        clearOpenSpace([$x, $y]);
    }

    $foreground[$x][$y] = "C";
    return [$x, $y];
}


#.....................................................
# clearOpenSpace([x,y])
#
# Takes a two element arry ref of a discovered open 
# space on the playground, and clears any adjacent 
# free space from foreground
#.....................................................
sub clearOpenSpace {
    my $thisPoint = shift;

    my $directions = [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]];
    my @dots;
    push @dots, $thisPoint;


    while (scalar @dots > 0) {
        $thisPoint = pop @dots;
        for my $p (@$directions) {
#           print "thisPoint = @$thisPoint - ", scalar @dots, "\n";
            my $try = [$thisPoint->[0] + $p->[0], $thisPoint->[1] + $p->[1]];
            if (
                    $try->[0] >= 0
                and $try->[1] >= 0
                and $try->[0] < $width 
                and $try->[1] < $height
               ) {
                if ($playground[$try->[0]][$try->[1]] =~ m/\./ and $foreground[$try->[0]][$try->[1]] ne 'C') {
                    $foreground[$try->[0]][$try->[1]] = 'C';
                    push @dots, [$try->[0], $try->[1]];
                }
                # also show adjacent numbers...
                if ( looks_like_number($playground[$try->[0]][$try->[1]]) ) {
                    $foreground[$try->[0]][$try->[1]] = 'C';
                }

            }

        }
    }
}


MineSweeper
===========
                                                                           
####_"Half Hour" Minesweeper, and then all the rest..._
                                                                           
The classic Minesweeper game has shipped with windows forever. This is a 
"just because" version for ANSI terminal. The color version will not work very well
on widows in the "Command Prompt" and maybe not in some other terminals either. You will see 
the ANSI control sequences insted of colored text. Look for a branch called "noColor" in the 
repo for another version without ANSI color, if you need it

Change $height, $width and $bombs to make a more challenging game. 

                                                                           
####Why?
                                                                           
This is just a quick and (hopefully) not too dirty response to a 
programming challenge: Write as much of minesweeper as you can in one
half hour. Text based only, and choose any language.
                                                                          
For speed I used Perl. In a half hour I got the bombs randomly 
placed in the playground and displayed on screen. I had started on the
number-of-nearby bombs part.
                                                                          
A few weeks later I sat down and finished it. It took another, maybe three 
hours. Not counting whatever thinking I did in the mean time.

####TODO

I wouldn't normally release a program that has the problems this one has. 
I excuse myself because I can say it's in the spirit of the challenge. It 
was finished quickly, and it's just a fun little game that seems to work fine.

However, if someone were to put more work into it I'd suggest that it could 
use some more error checking and some editing and correcting of the in-program
comments. Beyond that, I can think of a number of ways the structure of the 
program could be improved. 

But forget the small stuff. It should be possible to use mouse clicks to
interact with the program in the terminal, just like in the GUI game. 
That would be great!
                                                                       
&copy; 2012 Frank Lyon Cox

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself, either Perl version 5.10.1 or, at 
your option, any later version of Perl 5 you may have available.
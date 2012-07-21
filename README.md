MineSweeper
===========
                                                                           
####_"Half Hour" Minesweeper, and then all the rest..._
                                                                           
The classic Minesweeper game has shipped with windows forever. This is a 
"just because" version for ANSI terminal. The color version will not work very well
on widows in the "Command Prompt" and maybe not in some other terminals either. You will see 
the ANSI control sequences insted of colored text. Look for a branch called "noColor" in the 
repo for another version without ANSI color, if you need it.

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

I would not normally write a program of this length with global variables.
Also, there is no error checking in place at this point. I feel this is
in the spirit of the challenge. 
                                                                          
If it bugs me enough I may fix these problems some day. Unless you
do it first...
                                                                       
&copy; 2012 Frank Lyon Cox

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself, either Perl version 5.10.1 or, at 
your option, any later version of Perl 5 you may have available.










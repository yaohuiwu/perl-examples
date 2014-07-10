#!/usr/bin/perl
use v5.14;

open(NAME_FILE,">>","name") || die "Can't open grades:$!\n";

my $word = "";
while(($word = <STDIN>) ne "\n"){
   chomp($word);
   print NAME_FILE ("$word"); 
}

close NAME_FILE;

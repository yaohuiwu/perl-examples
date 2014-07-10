#!/usr/bin/perl
#这是一个演示复杂数据类型的程序。

use v5.14;

#Arrays
my @home=("luoyang","beijing","nanning");
say "My 1th home is $home[0].";
say "My 2th home is $home[1].";
say "My 3th home is $home[2].";

#Hashes
my %longday = (
	"Sun" => "Sunday",
	"Mon" => "Monday",
	"Tue" => "Tuesday",
	"Wed" => "Wednesday",
	"Thu" => "Thursday",
	"Fri" => "Friday",
	"Sat" => "Saturday" 
);

say "The full name of Sun is $longday{Sun}.";
say "The full name of Mon is $longday{'Mon'}.";
say "The full name of Sund is $longday{'Sund'}.";

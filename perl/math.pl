#!/usr/bin/perl
#This is a program testing verious perl operators。

use v5.14;

my $a = 3,$b = 4;

my $sum = $a + $b;
my $minus = $b -$a;
my $multiplication =  $a * $b;
my $division = $b / $a;

my $modulus = $b % $a;
my $exponentiation = $a ** $b;

say "sum:$sum\n" ."minus:$minus\n" ."multiplication:$multiplication\n" ."division:$division\n" ."modulus:$modulus\n" ."exponentiation:$exponentiation\n";


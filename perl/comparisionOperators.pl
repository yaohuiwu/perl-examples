#!/usr/bin/perl
#This is a program testing verious perl operators。

use v5.14;

if(2 >= 1){
	say "2 is greater than 1.";
}

if(1 == 1){
	say "1 is equal to 1.";
}

if(1 <= 2){
	say "1 is less than 2.";
}

if(-1 == (1 <=> 2)){
	say "compare result of 1 and 2 is :-1.";
}

if('a' eq 'a'){
	say "'a' is equal to 'a'";
}

if('a' ne 'b'){
	say "'a' is not equal to 'b'."
}

if('a' lt 'b'){
	say "'a' is less than 'b'.";
}

if('b' gt 'a'){
	say "'b' is greater than 'a'.";
}

if(1 == ('b' cmp 'a')){
	say "compare result of 'b' and 'a' is  1.";
}

# File test operators.
my $file = "comparisionOperators.pl";
if(-e $file){
	say "File named $file exists.";
}

if(-r $file){
	say "File named $file is readable.";
}

if(-w $file){
	say "File named $file is writable.";
}

if(-d $file){

}else{
 	say "File named $file is not a directory.";
}

if(-T $file){
	say "File named $file is a text file.";
}

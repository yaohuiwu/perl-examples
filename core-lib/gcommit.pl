#!/usr/bin/perl

use v5.14;
use Getopt::Long;

#say "@ARGV" ."len:$#ARGV";
if(1+$#ARGV < 2){
	say "用法:./gcommit.pl --b [Bug号] --d [Bug描述]";
	say "说明:";
	say "  --b [Bug号] 		Bug号可选,但是--b必须存在.Bug number默认为N/A.";
	say "  --d [Bug描述] 	Bug描述.";
	exit 0;
}

my $bug_num='';
my $description='';

GetOptions('b:s'=>\$bug_num,'d=s'=>\$description);

unless($bug_num){
	$bug_num = 'N/A';
}
my $bug_line= "BUG:$bug_num";
my $desc_line= "DESCRIPTION:$description";

my $cmd="echo -e \"" .$bug_line .'\n' .$desc_line .'" | git commit -F -';
say $cmd;
system($cmd);

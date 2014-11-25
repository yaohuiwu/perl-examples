#!/usr/bin/perl

use v5.14;
use Getopt::Long;

#say "@ARGV" ."len:$#ARGV";
if($#ARGV < 2){
	say "用法:./gcommit.pl --b [Bug号] --d [Bug描述]";
	say "说明:\n";
	say "  --b [Bug号] 		Bug号可选,但是--b必须存在.Bug number默认为N/A.";
	say "  --d [Bug描述] 	Bug描述.";
	say "\n  将gcommit.pl复制到可执行路径,如~/bin,方便执行.";
	exit 0;
}

my $bug_num='';
my $description='';

GetOptions('b:s'=>\$bug_num,'d=s'=>\$description);

unless($bug_num){
	$bug_num = 'N/A';
}

my $commit_msg = "BUG:$bug_num" ."\n" ."DESCRIPTION:$description";
say $commit_msg;

system("git commit -m $commit_msg");

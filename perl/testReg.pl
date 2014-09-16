#!/usr/bin/perl

use v5.14;

my $str = "Today is a sunny day"; 
$str =~ m/sunny/;
say $str;
say "length of str:".length($str);
say "left	: |$`| \t\t".length($`);
say "mid	: |$&| \t\t".length($&);
say "right	: |$'| \t\t".length($');

$str =~ s/sunny/cloudy/;
say "替换：$str";

$str =~ m/(.*) is a (.*) day/;
say "\$1:$1";
say "\$2:$2";

"hello world123" =~ m{
	\w+:
	(
		\s+
		\w+		#match one or more word.
	)
	\s*
	\d+
}x;

say "$1";

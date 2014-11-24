#!/usr/bin/perl

use v5.14;

my $helloRef = sub {
	say "Hello , anonymous Subroutine of Perl !";
};

#call the subroutine indirectly.
&$helloRef();
$helloRef->();
&$helloRef;

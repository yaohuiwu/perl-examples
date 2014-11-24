#!/usr/bin/perl

use v5.14;

sub hello {
	say "Hello , Subroutine of Perl !";
}

#call the func directly.
hello();
hello;
&hello;

my $hellRef = \&hello;
#call the func indirectlyi.
&$hellRef();
$hellRef->();
&$hellRef;

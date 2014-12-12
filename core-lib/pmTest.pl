#!/usr/bin/perl

use v5.14;

say "match" if "abccat c" =~ m/\bcat\b/;

my $sen = "I am a software engineer who is designing software.";
my $r = $sen =~ s/\bsoftware\b/web/g;
say $r;
say $sen;

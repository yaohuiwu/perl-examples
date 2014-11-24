#!/usr/bin/perl

use v5.14;
use Getopt::Long;

my $verbose='';
my $all='';
my $size=0;

GetOptions('verbose'=>\$verbose,'all'=>\$all,'size=s'=>\$size);

say "verbose:$verbose";
say "all:$all";
say "size:$size";


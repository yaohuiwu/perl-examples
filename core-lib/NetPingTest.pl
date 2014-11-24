#!/usr/bin/perl

use v5.14;
use warnings;
use Getopt::Long;
use Net::Ping;

my $host='localhost';
GetOptions('host=s'=>\$host);

say "Ping $host";
my $p = Net::Ping->new("icmp");
#my $p = Net::Ping->new();
my $p_result = $p->ping($host);
say "Ping result : ".$p_result;
$p->close();


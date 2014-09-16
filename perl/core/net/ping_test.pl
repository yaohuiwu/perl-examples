#!/usr/bin/perl

#use v5.14;
use Net::Ping;

my $host="www.baidu.com";
my $p = Net::Ping->new();

if( $p->ping($host,5000) ){
	print "$host is alive\n" ;
}else{
	print "$host is not alive.\n";
}
$p->close();

#!/usr/bin/perl

use v5.14;
use warnings;
use autodie;
use IO::Socket::INET;

#say "echo client v1.0";
my $remote_host="localhost";
my $remote_port="8084";

my $s = IO::Socket::INET->new(
				PeerAddr => $remote_host,
				PeerPort => $remote_port,
				Type	 => SOCK_STREAM,
			);
if(!$s){
	die "Can not connect to $remote_host:$remote_port.";
}

my $msg_i = 0;
my $msg_total = 10;
my $slp_interval = 1;

while($msg_i < $msg_total){
	say "send msg $msg_i";
	print $s "$msg_i Hello, echo server\r\n";

	#read msg from server
	my $resp_msg = <$s> =~ s/\R\z//r;
	say "got respose: $resp_msg";

	$msg_i++;
	
	say "sleep for $slp_interval seconds...";
	sleep $slp_interval;
}
say "close socket.";
close($s);

#!/usr/bin/perl

use v5.14;
use Getopt::Long;
use LWP::UserAgent;
use JSON::PP;

my $host='localhost';
my $port=8080;
my $device_id;
my $times=10;

GetOptions("h=s"=>\$host,"p=i"=>\$port,"did=s"=>\$device_id,"t=i"=>\$times)
or die("Usage : ./realtime-client.pl -h 192.168.10.57 -p 9110 -did=8a8088824a376c74014a37d60d1a00a6 -t 11\n");

my $ua=LWP::UserAgent->new;
$ua->agent("LWP/0.1");

my $cookie=login('daiwz@zjipst.com','pekall1234',1);
#say "cookie:$cookie";

say "start tracking device:$device_id";
my $browser_id=start_tracking($device_id);
say $browser_id;

my $count = $times;

while($count>0){
	say $count;
	say get_current_locations($device_id,$browser_id);
	$count--;
	sleep 5;
}

stop_tracking($device_id,$browser_id);

sub url{
	my ($h,$p,$path) = @_;
    return 'http://'.$h.':'.$p.$path;
}

sub log_resp{
	my ($resp)=@_;
	say $resp->status_line;
	my $content=$resp->content;
	if($content){
		say $resp->content;
	}
}

sub login{
	my ($username,$password,$type)=@_;
	my $req = HTTP::Request->new(POST=>url($host,9100,'/auth/v1/login'));
	$req->content_type('application/x-www-form-urlencoded');
	$req->content("username=$username&password=$password&type=$type");

	my $res=$ua->request($req);
	log_resp($res);
	if($res->is_success){
		return $res->header('Set-Cookie');
	}else{
		die "login error!\n";
	}
}

sub start_tracking{
	my ($dev_id)=@_;
	my $req = HTTP::Request->new(POST=>url($host,$port,'/mdm/v1/devices/geotracking/start'));
	$req->content_type('application/x-www-form-urlencoded');
	$req->content("deviceId=$dev_id");
	$req->header("Cookie",$cookie);

	my $res=$ua->request($req);
	log_resp($res);
	if($res->is_success){
		my $hash = decode_json $res->content;	
		return $$hash{'browserId'};
	}else{
		die "start tracking error!\n";
	}
}

sub stop_tracking{
	say "stop tracking...";
	my ($dev_id,$brow_id)=@_;
	my $req = HTTP::Request->new(POST=>url($host,$port,'/mdm/v1/devices/geotracking/stop'));
	$req->content_type('application/x-www-form-urlencoded');
	$req->content("deviceId=$dev_id&browserId=$brow_id");
	$req->header("Cookie",$cookie);

	my $res=$ua->request($req);
	log_resp($res);
	unless($res->is_success){
		die "stop tracking error!\n";
	}
}

sub get_current_locations{
	my ($dev_id,$browser_id)=@_;
	my $req = HTTP::Request->new(GET=>url($host,$port,'/mdm/v1/devices/geotracking/current_locations?'."deviceId=$dev_id&browserId=$browser_id"));
	$req->content_type('application/x-www-form-urlencoded');
	$req->header("Cookie",$cookie);

	my $res=$ua->request($req);
	#log_resp($res);
	if($res->is_success){
		return $res->content;
	}
	else{
		die "get current location error!\n";
	}
}

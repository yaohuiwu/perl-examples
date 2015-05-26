#!/usr/bin/perl

# A small script to update tenant count of operation server.

use DBI;
use strict;
use Time::Local 'timelocal_nocheck';

my $dbh = DBI->connect("dbi:mysql:mdm_operation:localhost:3306", "root", "pekall1234") 
or die $DBI::errstr;

print "connect successful to localhost.\n";

my $sth = $dbh->prepare("select now()");
$sth->execute();

while(my @row = $sth->fetchrow_array){
	print "@row\n";
}

$dbh->disconnect;

print localtime;

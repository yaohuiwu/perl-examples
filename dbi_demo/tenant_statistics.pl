#!/usr/bin/perl

# A small script to update tenant count of operation server.
# install module DBI, DBD::mysql first.
use DBI;
use Time::Local 'timelocal_nocheck';
 use Time::Piece;
use strict;

my $host_op = "localhost";
my $mdm_csv = "mdm.csv";

open(MDM_F, "< :encoding(UTF-8)", $mdm_csv);
binmode(STDOUT, ':utf8');
<MDM_F>; #skip header line

#my $dbh_op = DBI->connect("dbi:mysql:mdm_operation:$host_op:3306", 'root', 'pekall1234');
#my $sth = $dbh->prepare("insert into mdm_deployment (id, name, version, tenant_count, create_time, update_time) values (?,?,?,?,?,?)");

my $dbh_op = create_connection('mdm_operation', $host_op, undef, undef, undef);
#set charset env.
$dbh_op->do("SET character_set_client='utf8'");
$dbh_op->do("SET character_set_connection='utf8'");
$dbh_op->do("SET character_set_results='utf8'");

my $sth_op = $dbh_op->prepare("insert into mdm_deployment (id, name, version, host, port, tenant_count, create_time, update_time) values (?,?,?,?,?,?,?,?)");

$dbh_op->do("delete from mdm_deployment");
$dbh_op->do("delete from mdm_com_deployment");

while(my $line=<MDM_F>){
	chomp($line);
	my @row = split(",", $line);
	print "@row \n\n";

	my 	$name = $row[0];
	chomp($name);
	my	$version = $row[1];
	chomp($version);
	my	$host = $row[2];
	chomp($host);
	my	$port = $row[3];
	chomp($port);
	
	my $db_host = $row[4] ? $row[4] : $host;
	
	# create mdm connection
	my $dbh_mdm = create_connection('mdm_reactor', $db_host, $row[5], $row[6], $row[7]);
	if($dbh_mdm == undef){
		print "$DBI::errstr \n";
		next;
	}

	my $count = count($dbh_mdm);
	print "$count comany in $host\n\n";

	#create deployment
	my $deploy_id = createUUID();
	$sth_op->execute($deploy_id, $name, $version, $host, $port, $count, now(), now());
	my $com_id_arr = get_com_id_array($dbh_mdm);
	create_com_deployments($deploy_id , $com_id_arr);

	$dbh_mdm->disconnect();
}

$sth_op->finish();
$dbh_op->disconnect();

close(MDM_F);

sub createUUID{
	my $uuid = `uuidgen`;
	$uuid =~ s/\-//g;
	chomp($uuid);
	return $uuid;
}

sub now{
	my $t = localtime;
	my $now = $t->datetime;
    	$now =~ y/T/ /;
	return $now;
}


sub create_connection{
	my ($db_name, $db_host, $db_port, $db_user, $db_password) = @_;
	if(!$db_port){
		$db_port = 3306;
	}
	if(!$db_user){
		$db_user = 'root';
	}
	if(!$db_password){
		$db_password = 'pekall1234';
	}
	return DBI->connect("dbi:mysql:$db_name:$db_host:$db_port", $db_user, $db_password);
}

sub count{
	my $dbh = shift(@_);
	my $sth = $dbh->prepare("select count(*) from mdm_company_info");
	$sth->execute();

	my $count = 0;
	while(my @row = $sth->fetchrow_array){
		$count = $row[0];
	}
	return $count;
}


# Create company deployment relations
sub create_com_deployments{
	my ($deploy_id, $com_id_arr) = @_;
	
	my $sth = $dbh_op->prepare("insert into mdm_com_deployment (id, deployment_id, tenant_id) values (?,?,?)");
	for my $com_id (@$com_id_arr){
		my $uuid = createUUID();
		$sth->execute($uuid, $deploy_id, $com_id);
		print "id=$uuid, com_id=$com_id, deploy_id=$deploy_id\n";
	}

	$sth->finish();
}

sub get_com_id_array{
	my @com_id_list;
	
	my $dbh = shift(@_);
	my $sth = $dbh->prepare("select id from mdm_company_info");
	$sth->execute();

	while(my @row = $sth->fetchrow_array){
		push @com_id_list, $row[0];
	}
	$sth->finish();
	return \@com_id_list;
}

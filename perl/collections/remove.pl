#!/usr/bin/perl

use v5.14;
use Getopt::Long;

my $all;
my $part;
my $out;

Getopt::Long::GetOptions(
	'a=s'=> \$all,
	'p=s'=> \$part,
	'o:s'=> \$out
);

if(!$all or !$part){
	say"Usage: remove.pl -a all_file -p part_file";
	exit 0;
}

my @all = &getCsv($all,1);
my @part = &getCsv($part,1);

my $f=$out ? $out: "r.txt";

open(F,">",$f);
for my $stu (@all){
	if(!&contain(\@part,$stu)){
		print F $stu,"\n";
	}
}
close(F);


#读取CSV格式的文件的某一列
#	arg[0]:文件名
#	arg[1]:列号
sub getCsv{
	my ($file_nm,$col_num) = @_ ;
	#for $_ (@_){
	#	say $_;
	#}
	#say $file_nm ."\t" .$col_num;
	open(FILE,"<",$file_nm) || die "Can't open $file_nm";
	my @col;
	my $count = 0;
	while(<FILE>){
		my @tmp = split /\s+/;
		$col[$count]=$tmp[$col_num-1];
		#say $col[$count];
		$count ++;
	}
	close FILE;
	return @col;
}

sub contain{
	my ($array,$item)=@_;
	for my $s (@$array){
		if($s eq $item){
			return 1;
		}
	}
	return 0;
}

#!/usr/bin/perl
#这是一个演示复合数据类型的程序。

use v5.14;

#Hash contain array
my %wifes;
$wifes{"jacob"} = ["小红","小王"];
$wifes{"tom"} = ["小玲","小李"];

say "1th wife of jacob:".$wifes{"jacob"}[0];

my %kids_of_wife;
$kids_of_wife{"jacob"} = {
    "Leah" => ["Reuben","Semeon","Levi"],
    "Rachel" => ["Joseph","Benjamin"]
};

say "$kids_of_wife{'jacob'}{'Leah'}[0]";

my $ifdo = Camel->new("America");

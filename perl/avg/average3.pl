#!/usr/bin/perl
use v5.14;

open(GRADES,"<:utf8","grades") || die "Can't open grades:$!\n";
binmode(STDOUT,':utf8');

my %grades;
while(my $line = <GRADES>){
    my ($student,$grade) = split(" ",$line);
    if( $grades{$student} eq ""){
        $grades{$student} = [];
    }
    my @arr = $grades{$student};
    my $len = push $grades{$student},$grade;
   # say "len of $student:".$len;
}

for my $student (sort keys %grades){
    my $total = 0;
    my $average = 0;
    my $scores = 0;
    #Here we use @{}
    for my $score (@{$grades{$student}}){
        $total += $score;
        $scores++;
    }
    $average = $total / $scores;
    say "$student\ttotal:".$total ."\taverage:".$average;
}

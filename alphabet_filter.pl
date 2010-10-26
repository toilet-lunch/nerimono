#!/usr/bin/perl -w

use Unicode::Normalize;
use strict;

while(my $line = <STDIN>){
    chomp($line);
    my @word = split(/\ /,$line);
    for(my $i=0;$i<@word;$i++){
	my @tmp = &isAllAlphabet($word[$i]);
	if(!exists($hash{$tmp[0]})){
	    $hash{$tmp[0]} = $score;
	}
    }
}

sub isAllAlphabet{
    my $word = $_[0];
    $word = lc NFKC($word);
    my $score = 0;
    if($word !~ /[^ -~]+/ && $score ne ""){
	$score = 1;
    }
    return ($word,$score);
}

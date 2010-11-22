#!/usr/bin/perl -w

use strict;
use Encode;
use lib '../lib';
use WordScore;

my $testFile = "./sample_input";

open(IN,"<",$testFile) or die "$!:$testFile";
while(my $line = <IN>){
    chomp($line);
    my @words = split(/ /,$line);
    my $wordObj = WordScore->new(\@words);
    my %result = $wordObj->execute();
    my $count = 0;
    print "<Rank>\n";
    foreach my $word (sort {$result{$b} <=> $result{$a}} keys %result){
	print encode_utf8($word) . "\t" . $result{$word} . "\n";
	$count++;
	if($count > 10){
	    last;
	}
    }
    print "</Rank>\n";
    print "<Input>\n";
    print $line . "\n";
    print "</Input>\n";
    print "\n\n";
}
close(IN);



exit;

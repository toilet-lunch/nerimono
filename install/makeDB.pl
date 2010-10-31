#!/usr/bin/perl -w

use strict;
use TokyoCabinet;

my ( $datDir, $gram ) = @ARGV;
$datDir =~ s/\/$//;

my $file = $datDir . '/' . $gram . 'gm-0000';
my $tch = $datDir . '/' . $gram . 'gm-0000.tch';

my $hdb = TokyoCabinet::HDB->new();

unlink($tch);
$hdb->open($tch, $hdb->OWRITER | $hdb->OCREAT);

open(IN,"<",$file) or die "$!:$file";
while(my $line = <IN>){
    chomp($line);
    my @tmp = split(/\t/,$line);
    $tmp[0] =~ s/ //g;
    $hdb->put("$tmp[0]","$tmp[1]");
}
close(IN);

exit;

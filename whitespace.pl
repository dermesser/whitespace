#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use File::Copy;

die("Usage: whitespace.pl <FILE>\n") if scalar @ARGV != 1;

open(my $tempfile,">",".white_tmp");
open(my $file,"<",$ARGV[0]);

my $pat = qr/^(\t| )+$/;
my $i = 0;

while ( my $line = <$file> )
{
	$i++;

	if ( $line =~ $pat )
	{
		#print $i." ".$line;
		print $tempfile "\n";
	} else
	{
		print $tempfile $line;
	}
}

close($file);
close($tempfile);

copy(".white_tmp",$ARGV[0]);

unlink(".white_tmp");

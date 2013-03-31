#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use File::Copy;

die("Usage: whitespace.pl <FILE>\n") if scalar @ARGV == 0;

my $pat_emptyline = qr/^(\t| )+$/;
my $pat_endofline = qr/^(.+?)( |\t)+$/;

foreach my $actual_file (@ARGV)
{
    next if -d $actual_file;
    open(my $tempfile,">",".white_tmp");
    open(my $file,"<",$actual_file);

    my $i = 0;

    while ( my $line = <$file> )
    {
	$i++;

	if ( $line =~ $pat_emptyline )
	{
	    #print $i." ".$line;
	    print $tempfile "\n";
	} elsif ( $line =~ $pat_endofline )
	{
	    print $tempfile $1 . "\n";
	} else
	{
	    print $tempfile $line;
	}
    }

    close($file);
    close($tempfile);

    copy(".white_tmp",$actual_file);

    unlink(".white_tmp");
}

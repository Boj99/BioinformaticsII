#!usr/bin/perl -w
use strict;


undef $/; 

my $line = <>;

my @codon = $line =~ /[A-Z]{3}/g;
my @freq = $line =~ /\d*\.\d*/g;
my @letter = $line =~ /\((\w{1})\)/g;

########################################################################

use List::MoreUtils qw(each_array);

# prepare the INSERT statement
my $sth_insert = $dbh->prepare('INSERT INTO codon SET codon=?, codon_freq=?, one_letter_id=?')
	or die $dbh->errstr;

# create the array iterator
my $ea = each_array(@codon, @freq, @letter);
# iterate over all three arrays step by step
while ( my ($val_a, $val_b, $val_c) = $ea->() ) {
	$sth_insert->execute($val_a, $val_b, $val_c) or die $dbh->errstr;
}

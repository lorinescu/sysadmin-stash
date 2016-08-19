#!/usr/bin/perl

# usage:
# s3-audio-index.pl <key> <secret> /var/www/my_site/audio.html

use Net::Amazon::S3;
use Data::Dumper;

my $key = shift;
my $secret = shift;

my $s3 = Net::Amazon::S3->new(
    aws_access_key_id     => $key,
    aws_secret_access_key => $secret,
    retry                 => 1,
);

my $client = Net::Amazon::S3::Client->new( s3 => $s3 );
my $bucket = $client->bucket( name => 'bucket.acme.org' );

my $map = {};
my $object_stream = $bucket->list;
until ( $object_stream->is_done ) {
    foreach my $object ( $object_stream->items ) {
        my $key = $object->key;

	if ( $key =~ m/\$folder\$/ ) {
		next;
	}

	my ($top_folder,$sub_folder,$file) = split('/',$key);
	push(@{$map->{$top_folder}{$sub_folder}},$file);
    }
}

foreach my $top_folder ( sort {$b cmp $a} keys %$map) {

	print "<h3> $top_folder </h3>\n";

	print "<table>";
	foreach my $sub_folder ( sort {$b cmp $a} keys %{$map->{$top_folder}}) {

	print "<tr><td> <b> $sub_folder </b></td><td></td><td></td></tr> </h3>\n";
		foreach (@{$map->{$top_folder}{$sub_folder}}) {
			print "<tr>";
			print "\t\t<td> <a href=http://bucket.acme.org/$top_folder/$sub_folder/$_> $_ </a></td>\n";
			print "\t\t<td> <audio controls=controls preload=none><source src=http://bucket.acme.org/$top_folder/$sub_folder/$_ /></audio></td></tr> \n";
		}
	}

	print "</table>";
} 

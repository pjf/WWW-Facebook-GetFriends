#!/usr/bin/perl -w
use 5.010;
use strict;
use warnings;
use autodie;
use FindBin qw( $Bin );
use lib "$Bin/../blib/lib";

use WWW::Facebook::GetFriends;
use YAML;

@ARGV or die "Usage: $0 uid\n";

my $fb      = WWW::Facebook::GetFriends->new;
my $friends = $fb->get_friends($ARGV[0]);

print YAML::Dump($friends);

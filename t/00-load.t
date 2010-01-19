#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'WWW::Facebook::GetFriends' );
}

diag( "Testing WWW::Facebook::GetFriends $WWW::Facebook::GetFriends::VERSION, Perl $], $^X" );

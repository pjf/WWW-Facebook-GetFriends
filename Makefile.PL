use inc::Module::Install;

name     'WWW-Facebook-GetFriends';
all_from 'lib/WWW/Facebook/GetFriends.pm';
author   'Paul Fenwick <pjf@cpan.org>';

build_requires 'Test::More';

requires 'JSON::Any';
requires 'LWP::UserAgent';
requires 'Carp';

WriteAll;


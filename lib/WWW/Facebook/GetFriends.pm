package WWW::Facebook::GetFriends;

use warnings;
use strict;
use JSON::Any;
use LWP::UserAgent;
use Carp;
use constant FRIENDS_URL => "http://www.facebook.com/ajax/typeahead_friends.php?u=%s&__a=1";

=head1 NAME

WWW::Facebook::GetFriends - Get friends from Facebook via JSON

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Retrieve friends of a person from Facebook by using AJAX/JSON calls.

    use WWW::Facebook::GetFriends;

    my $fb = WWW::Facebook::GetFriends->new();

    $fb->get_friends(...);

=head1 METHODS

=cut

sub new {
    my ($class, @args) = @_;

    my $this = {};

    bless($this,$class);

    return $this->_init(@args);
}

sub _init {
    my ($this) = @_;

    $this->{agent} = LWP::UserAgent->new( agent => "Mozilla/5.0" );
    $this->{json}  = JSON::Any->new;

    return $this;
}

sub agent { return $_[0]->{agent} }
sub json  { return $_[0]->{json}  }

sub get_friends {
    my ($this, $uid) = @_;

    my $json = $this->get_friends_json($uid);

    my $data = $this->json->jsonToObj( $json );

    return $data;
}

=head2 get_friends

=cut

sub get_friends_json {
    my ($this, $uid) = @_;

    if ( $uid !~ /^\d+$/ ) {
        if (not defined $uid) { $uid = "undef" }
        croak "->get_friends() requires numeric profile ID (not $uid)";
    }

    my $agent = $this->agent;

    my $response = $agent->get( sprintf(FRIENDS_URL, $uid) );

    if ($response->is_success) {
        my $content = $response->content;

        $content =~ s/\Qfor (;;);\E//;

        return $content;
    }
}

=head1 AUTHOR

Paul Fenwick, C<< <pjf at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-facebook-getfriends at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Facebook-GetFriends>.  I
will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Facebook::GetFriends

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Facebook-GetFriends>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Facebook-GetFriends>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Facebook-GetFriends>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Facebook-GetFriends>

=back


=head1 ACKNOWLEDGEMENTS

@theharmonyguy for finding delicious buttery JSON calls.

@selenamarie and @gnat for thinking of wrong things to do with Facebook.

=head1 COPYRIGHT & LICENSE

Copyright 2010 Paul Fenwick, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;

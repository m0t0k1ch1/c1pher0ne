package Cipherone::Role::Twitter;
use Mouse::Role;
use utf8;

use Net::Twitter;

has twitter => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build_twitter {
    my $self = shift;

    Net::Twitter->new(
        traits => [qw/API::RESTv1_1/],
        %{ $self->config('twitter') },
    );
}

1;

package Cipherone::Role::Bitly;
use Mouse::Role;
use utf8;

use WebService::Bitly;

has bitly => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build_bitly {
    my $self = shift;

    WebService::Bitly->new(%{ $self->config('bitly') });
}

1;

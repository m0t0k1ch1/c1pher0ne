package Cipherone::Role::Bitly;
use Mouse::Role;

use WebService::Bitly;

has bitly => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build_bitly {
    my $self = shift;

    my $bitly_config = $self->config('bitly');

    WebService::Bitly->new(
        user_name    => $bitly_config->{user_name},
        user_api_key => $bitly_config->{api_key},
    );
}

1;

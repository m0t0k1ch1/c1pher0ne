package Cipherone::Model::Twitter;
use Mouse;
extends 'Cipherone::Model';

use Net::Twitter;

has twitter => (
    is         => 'rw',
    lazy_build => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _build_twitter {
    my $self = shift;

    my $twitter_config = $self->config->{twitter};

    Net::Twitter->new(
        traits              => [qw/API::RESTv1_1/],
        consumer_key        => $twitter_config->{consumer_key},
        consumer_secret     => $twitter_config->{consumer_secret},
        access_token        => $twitter_config->{access_token},
        access_token_secret => $twitter_config->{access_token_secret},
    );

}

1;

package Cipherone::Schema::MediaRanking;
use Mouse;
extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'media_ranking'
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

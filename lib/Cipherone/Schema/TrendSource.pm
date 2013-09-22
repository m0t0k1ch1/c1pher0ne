package Cipherone::Schema::TrendSource;
use Mouse;
extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'trend_source',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

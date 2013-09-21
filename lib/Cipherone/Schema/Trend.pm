package Cipherone::Schema::Trend;
use Mouse;
extends 'Cipherone::Schema';

has table => (
    is      => 'rw',
    default => 'trend',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

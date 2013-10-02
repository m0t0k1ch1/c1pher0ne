package Cipherone::Batch;
use Mouse;

use Cipherone;

has cipherone => (
    is      => 'rw',
    default => sub {
        Cipherone->new;
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

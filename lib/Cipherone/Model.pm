package Cipherone::Model;
use Mouse;

with (
    'Cipherone::Util::Role::Singleton',
);

has config => (
    is       => 'rw',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

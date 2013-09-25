package Cipherone;
use Mouse;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
    'Cipherone::Role::Twitter',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

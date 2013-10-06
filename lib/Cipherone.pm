package Cipherone;
use Mouse;
use utf8;

with (
    'Cipherone::Role::Batch',
    'Cipherone::Role::Bitly',
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
    'Cipherone::Role::Singleton',
    'Cipherone::Role::Twitter',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

package Cipherone::Model;
use Mouse;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Singleton',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

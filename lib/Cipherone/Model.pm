package Cipherone::Model;
use Mouse;

with (
    'Cipherone::Role::Singleton',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

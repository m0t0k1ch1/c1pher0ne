package Cipherone::Daemon;
use Mouse;
use utf8;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Singleton',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

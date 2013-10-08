package Cipherone::Daemon::Twitter::Response;
use Mouse;
use utf8;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Singleton',
    'Cipherone::Role::Twitter',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

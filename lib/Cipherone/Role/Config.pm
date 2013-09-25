package Cipherone::Role::Config;
use Mouse::Role;

has config => (
    is      => 'ro',
    default => sub {
        do 'config.pl' || die $!;
    },
);

1;
